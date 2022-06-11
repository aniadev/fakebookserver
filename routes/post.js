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

function makeNotification(
  notiType = 'GENERAL',
  notiMessage = 'GENERAL message',
  userId
) {
  if (!userId) {
    return {
      success: false,
      message: 'Empty user ID',
    };
  }
  return sqlQuery(`SELECT * FROM notifications ORDER BY time DESC`)
    .then((result) => {
      return {
        success: true,
        result,
      };
    })
    .catch((err) => {
      return err;
    });
}

// API:GET /post/:id
router.get('/:id', Auth, (req, res) => {
  //   console.log(req.query);
  var response = {
    success: true,
    postData: {},
    allComments: [],
    reactors: [],
  };
  try {
    let postId = req.params.id;
    if (postId < 0 || isNaN(postId)) {
      throw new Error('404 not found');
    }
    let queryFieldsPost =
      'posts.post_id AS postId,posts.user_id AS userId, avatar, content, likes, comments, time, name, users.blue_tick AS blueTick, images.link AS image';
    let sqlPost = `SELECT ${queryFieldsPost} FROM posts JOIN users ON posts.user_id = users.user_id LEFT JOIN images ON posts.post_id = images.post_id WHERE posts.post_id = ${postId} `; //AND posts.deleted = 0

    sqlQuery(sqlPost)
      .then((postData) => {
        if (postData[0]) {
          // query comments
          response = { ...response, postData: { ...postData[0] } };
          if (response.postData.comments) {
            let sqlCmt = `SELECT cmt_id AS cmtId, post_id AS postId, cmt_content AS cmtContent, comment_table.user_id AS userCmtId, users.name, users.avatar,users.blue_tick AS blueTick, time AS cmtTime FROM comment_table LEFT JOIN users ON comment_table.user_id = users.user_id WHERE post_id = ${postId} AND deleted = 0 ORDER BY time DESC`; // AND deleted = 0
            return sqlQuery(sqlCmt);
          }
        } else {
          throw Error('404 not found');
        }
      })
      .then((allComments) => {
        // get all comments
        allComments ? ([...response.allComments] = allComments) : false;
        if (response.postData.likes) {
          let reactSql = `SELECT user_id FROM like_table WHERE post_id = ${postId} ORDER BY time DESC LIMIT 20`;
          return sqlQuery(reactSql);
        }
      })
      .then((allReacts) => {
        if (allReacts)
          allReacts.map((react) => {
            response.reactors.push(react.user_id);
          });
        res.json(response);
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

// API:POST /post/:id/cmt
router.post('/:id/cmt', Auth, async (req, res) => {
  var response = {
    success: true,
    message: 'comment successful',
    cmtId: null,
  };
  try {
    let postId = req.params.id;
    if (isNaN(postId)) {
      throw Error('post invalid');
    }
    let comment = htmlEntities.encode(req.body.comment, {
      mode: 'nonAsciiPrintable', // get raw text/html
    });
    if (!comment) {
      throw Error('comment invalid');
    }
    let userId = req.userId; // userId comments at postId with data

    let sqlFindPost = `SELECT post_id AS postId, comments FROM posts WHERE post_id = ${postId}`;
    let sqlInsertCmt = `INSERT INTO comment_table (cmt_content, post_id, user_id) VALUES ('${comment}', '${postId}', '${userId}')`;

    sqlQuery(sqlFindPost)
      .then((post) => {
        if (post[0]) {
          return sqlQuery(sqlInsertCmt);
        } else {
          throw Error('404 not found');
        }
      })
      .then((insertResult) => {
        response.cmtId = insertResult.insertId;
        return sqlQuery(
          `SELECT cmt_id FROM comment_table WHERE post_id = ${postId}`
        );
      })
      .then((cmtCounter) => {
        return sqlQuery(
          `UPDATE posts SET comments = ${cmtCounter.length} WHERE post_id = ${postId}`
        );
      })
      .then((result) => {
        res.json(response);
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
// API:POST /post/:id/react
router.post('/:id/react', Auth, async (req, res) => {
  try {
    let postId = req.params.id;
    if (isNaN(postId)) {
      throw Error('post invalid');
    }
    let userId = req.userId;
    let reactType = req.body.type; // react
    let action = req.body.action; // like/unlike

    switch (action) {
      case 'like': {
        let checkExistPost = `SELECT post_id AS postId FROM posts WHERE post_id = ${postId}`;
        sqlQuery(checkExistPost)
          .then((result) => {
            if (result[0]) {
              return result[0];
            } else {
              throw Error('404 not found');
            }
          })
          .then((result) => {
            let postId = result.postId;
            let checkExistReact = `SELECT like_id AS likeId FROM like_table WHERE post_id = ${postId} AND user_id = ${userId}`;
            return sqlQuery(checkExistReact);
          })
          .then((existResult) => {
            if (existResult[0]) {
              return true;
            } else {
              let insertSql = `INSERT INTO like_table (user_id, post_id) VALUES ('${userId}', '${postId}')`;
              return sqlQuery(insertSql);
            }
          })
          .then(() => {
            let counterLikeSql = `SELECT like_id AS likeId FROM like_table WHERE post_id = ${postId}`;
            return sqlQuery(counterLikeSql);
          })
          .then((counterResult) => {
            let updatePostSql = `UPDATE posts SET likes = ${counterResult.length} WHERE post_id = ${postId}`;
            return sqlQuery(updatePostSql);
          })
          .then(() => {
            res.json({
              success: true,
              message: 'React successful',
            });
          })
          .catch((err) => {
            res.json({
              success: false,
              message: err.message,
            });
          });
        break;
      }
      case 'unlike': {
        let checkExistPost = `SELECT post_id AS postId FROM posts WHERE post_id = ${postId}`;
        sqlQuery(checkExistPost)
          .then((result) => {
            if (result[0]) {
              return result[0];
            } else {
              throw Error('404 not found');
            }
          })
          .then((result) => {
            let postId = result.postId;
            let checkExistReact = `SELECT like_id AS likeId FROM like_table WHERE post_id = ${postId} AND user_id = ${userId}`;
            return sqlQuery(checkExistReact);
          })
          .then((existResult) => {
            if (existResult[0]) {
              let likeId = existResult[0].likeId;
              let deleteSql = `DELETE FROM like_table WHERE like_id = ${likeId}`;
              return sqlQuery(deleteSql);
            } else {
              return true;
            }
          })
          .then((deleteResult) => {
            if (deleteResult) {
              res.json({
                success: true,
                message: 'unReact successful',
              });
            }
          })
          .then(() => {
            let counterLikeSql = `SELECT like_id AS likeId FROM like_table WHERE post_id = ${postId}`;
            return sqlQuery(counterLikeSql);
          })
          .then((counterResult) => {
            let updatePostSql = `UPDATE posts SET likes = ${counterResult.length} WHERE post_id = ${postId}`;
            return sqlQuery(updatePostSql);
          })
          .catch((err) => {
            res.json({
              success: false,
              message: err.message,
            });
          });
        break;
      }
      default: {
        res.json({
          success: false,
          message: 'action invalid',
        });
      }
    }
  } catch (error) {
    console.log(error.message);
    res.json({
      success: false,
      message: error.message,
    });
  }
});

module.exports = router;
