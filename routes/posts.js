const express = require('express');
const router = express.Router();
const mysql = require('../config/mysql');
const htmlEntities = require('html-entities');
const Auth = require('../middleware/Auth');

const sqlQuery = function (sql) {
  return new Promise(function (resolve, reject) {
    mysql.db.query(sql, function (error, result, fields) {
      if (error) {
        reject(error);
      } else {
        resolve(result);
      }
    });
  });
};

// API:GET /posts
router.get('/', Auth, (req, res) => {
  //   console.log(req.query);
  try {
    const userId = req.userId;
    if (isNaN(req.query._page)) {
      throw Error('_page invalid');
    }
    const page = req.query._page > 0 ? req.query._page - 1 : 0;
    const limit = req.query._limit || 10;
    const offset = req.query._offset || page * limit || 0;
    const queryFields =
      'posts.post_id AS postId,posts.user_id AS userId, avatar, content, likes, comments, posts.time, name, users.blue_tick AS blueTick, images.link AS image, like_table.like_id AS likeId';
    const sql = `SELECT ${queryFields} FROM posts JOIN users ON posts.user_id = users.user_id LEFT JOIN images ON posts.post_id = images.post_id LEFT JOIN like_table ON like_table.user_id = ${userId} AND like_table.post_id = posts.post_id WHERE posts.deleted = 0 ORDER BY time DESC LIMIT ${limit} OFFSET ${offset}`;
    sqlQuery(sql)
      .then((postList) => {
        res.json({
          success: true,
          page: page + 1,
          posts: postList,
        });
      })
      .catch((err) => {
        res.json({
          success: false,
          message: err.message,
        });
      });
  } catch (error) {
    res.json({
      success: false,
      message: error.message,
    });
  }
});

// API:POST /posts/create
router.post('/create', Auth, (req, res) => {
  try {
    let data = req.body;
    let userId = req.userId;
    let content = htmlEntities.encode(data.content, {
      mode: 'nonAsciiPrintable', // get raw text/html
    });
    if (!content && !data.imageLinks) {
      throw Error('Content invalid');
    }
    let images = data.imageLinks;
    let sqlPost = `INSERT INTO posts (user_id, content) VALUES ('${userId}', '${content}')`;
    let newPostId;
    sqlQuery(sqlPost)
      .then((result) => {
        newPostId = result.insertId;
        if (!images) {
          return true;
        } else {
          let sqlImg = `INSERT INTO images (link, post_id) VALUES ('${images}', '${result.insertId}')`;
          return sqlQuery(sqlImg);
        }
      })
      .then((result) => {
        res.json({
          success: true,
          message: 'create post successful',
          postCreated: {
            postId: newPostId,
            userId: req.userId,
            content,
            imageLinks: images,
          },
        });
      })
      .catch((err) => {
        res.json({
          success: false,
          message: err.message,
        });
      });
  } catch (error) {
    res.json({
      success: false,
      message: error.message,
    });
  }
});

// {
//  "content": "post - content",
//   "imageLinks" : "https://image.link"
// }

// API:POST /posts/delete
router.post('/delete', Auth, (req, res) => {
  try {
    let postId = req.body.postId;
    if (isNaN(postId)) {
      throw Error('PostId invalid');
    }
    let userId = req.userId;
    let checkPost = `SELECT deleted FROM posts WHERE post_id = '${postId}' AND user_id = '${userId}'`;
    sqlQuery(checkPost)
      .then((result) => {
        if (result[0]) {
          if (result[0].deleted) {
            return true;
          } else {
            // chua bi xoa ?
            let sqlDelete = `UPDATE posts SET deleted = 1 WHERE post_id = '${postId}' AND user_id = '${userId}'`;
            return sqlQuery(sqlDelete);
          }
        } else {
          throw Error('Permission invalid');
        }
      })
      .then(() => {
        res.json({
          success: true,
          message: 'delete post successful',
        });
      })
      .catch((error) => {
        res.json({
          success: false,
          message: error.message,
        });
      });
  } catch (error) {
    res.json({
      success: false,
      message: error.message,
    });
  }
});

module.exports = router;
