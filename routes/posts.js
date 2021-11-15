const express = require("express");
const router = express.Router();
const mysql = require("../config/mysql");
const htmlEntities = require("html-entities");
const Auth = require("../middleware/Auth");

// API:GET /posts
router.get("/", Auth, async (req, res) => {
  //   console.log(req.query);
  try {
    const page = req.query._page > 0 ? req.query._page - 1 : 0;
    const limit = req.query._limit || 10;
    const offset = req.query._offset || page * limit || 0;
    const queryFields =
      "posts.post_id AS postId,posts.user_id AS userId, avatar, content, likes, comments, time, name, users.blue_tick AS blueTick, images.link AS image";
    const sql = `SELECT ${queryFields} FROM posts JOIN users ON posts.user_id = users.user_id LEFT JOIN images ON posts.post_id = images.post_id WHERE posts.deleted = 0 ORDER BY time DESC LIMIT ${limit} OFFSET ${offset}`;
    mysql.db.query(sql, function (error, postList, fields) {
      if (error) throw error;
      res.json({
        success: true,
        page: page + 1,
        posts: postList,
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
router.post("/create", Auth, async (req, res) => {
  let data = req.body;
  let userId = req.userId;
  let content = htmlEntities.encode(data.content, {
    mode: "nonAsciiPrintable", // get raw text/html
  });
  let images = data.imageLinks;
  // console.log(req.body);
  // console.log(content);
  let sqlPost = `INSERT INTO posts (user_id, content) VALUES ('${userId}', '${content}')`;
  // const sqlImg = `INSERT INTO images (link, post_id) VALUES ('${data.images}', '${result.insert_id}')`;

  // use callback function
  if (!images) {
    try {
      mysql.db.query(sqlPost, function (error, result) {
        if (error) throw error;
        if (result) {
          res.json({
            success: true,
            message: "create post successful",
            postCreated: {
              postId: result.insertId,
              userId: req.userId,
              content,
              imageLinks: images,
            },
          });
        }
      });
    } catch (error) {
      console.log("🚀 ~ file: posts.js ~ line 41 ~ router.post ~ error", error);
    }
  } else {
    try {
      mysql.db.query(sqlPost, function (error, result) {
        if (error) throw error;
        // console.log(result);
        let sqlImg = `INSERT INTO images (link, post_id) VALUES ('${images}', '${result.insertId}')`;
        mysql.db.query(sqlImg, function (error, result) {
          if (error) throw error;
          if (result) {
            res.json({
              success: true,
              message: "create post successful",
              postCreated: {
                postId: result.insertId,
                userId: req.userId,
                content,
                imageLinks: images,
              },
            });
          }
        });
      });
    } catch (error) {
      console.log("🚀 ~ file: posts.js ~ line 90 ~ router.post ~ error", error);
    }
  }
});

// {
//  "content": "post - content",
//   "imageLinks" : "https://image.link"
// }

// API:POST /posts/delete
router.post("/delete", Auth, async (req, res) => {
  try {
    let postId = req.body.postId;
    let userId = req.userId;
    let checkPost = `SELECT deleted FROM posts WHERE post_id = '${postId}' AND user_id = '${userId}'`;
    mysql.db.query(checkPost, function (error, result) {
      if (error) throw error;
      if (result[0].deleted === 0) {
        // chua bi xoa ?
        let sqlDelete = `UPDATE posts SET deleted = 1 WHERE post_id = '${postId}' AND user_id = '${userId}'`;
        mysql.db.query(sqlDelete, function (error, result) {
          if (error) throw error;
          res.json({
            success: true,
            message: "delete post successful",
          });
        });
      } else {
        res.json({
          success: false,
          message: "delete post failed",
        });
      }
    });
  } catch (error) {
    console.log(error);
    res.json({
      success: false,
      message: "delete post failed",
    });
  }
});

module.exports = router;
