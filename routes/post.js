const express = require("express");
const router = express.Router();
const mysql = require("../config/mysql");
const htmlEntities = require("html-entities");
const Auth = require("../middleware/Auth");

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

// API:GET /post/:id
router.get("/:id", Auth, (req, res) => {
  //   console.log(req.query);
  var response = {
    success: true,
    postData: {},
    allComments: [],
  };
  try {
    let postId = req.params.id;
    if (postId < 0 || isNaN(postId)) {
      throw new Error("404 not found");
    }
    let queryFieldsPost =
      "posts.post_id AS postId,posts.user_id AS userId, avatar, content, likes, comments, time, name, users.blue_tick AS blueTick, images.link AS image";
    let sqlPost = `SELECT ${queryFieldsPost} FROM posts JOIN users ON posts.user_id = users.user_id LEFT JOIN images ON posts.post_id = images.post_id WHERE posts.post_id = ${postId} `; //AND posts.deleted = 0

    sqlQuery(sqlPost)
      .then((postData) => {
        if (postData[0]) {
          // query comments
          response = { ...response, postData: { ...postData[0] } };
          if (postData[0].comments) {
            let sqlCmt = `SELECT cmt_id AS cmtId, post_id AS postId, cmt_content AS cmtContent, comment_table.user_id AS userCmtId, users.name, users.avatar,users.blue_tick AS blueTick, time AS cmtTime FROM comment_table LEFT JOIN users ON comment_table.user_id = users.user_id WHERE post_id = ${postId} AND deleted = 0 ORDER BY time DESC`; // AND deleted = 0
            return sqlQuery(sqlCmt);
          }
        } else {
          throw Error("404 not found");
        }
      })
      .then((allComments) => {
        response = { ...response, allComments };
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
router.post("/:id/cmt", Auth, async (req, res) => {
  var response = {
    success: true,
    message: "comment successful",
    cmtId: null,
  };
  try {
    let postId = req.params.id;
    let comment = htmlEntities.encode(req.body.comment, {
      mode: "nonAsciiPrintable", // get raw text/html
    });
    let userId = req.userId; // userId comments at postId with data

    let sqlFindPost = `SELECT post_id AS postId, comments FROM posts WHERE post_id = ${postId}`;
    let sqlInsertCmt = `INSERT INTO comment_table (cmt_content, post_id, user_id) VALUES ('${comment}', '${postId}', '${userId}')`;

    sqlQuery(sqlFindPost)
      .then((post) => {
        if (post[0]) {
          return sqlQuery(sqlInsertCmt);
        } else {
          throw Error("404 not found");
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

module.exports = router;
