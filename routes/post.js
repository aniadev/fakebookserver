const express = require("express");
const router = express.Router();
const mysql = require("../config/mysql");
const htmlEntities = require("html-entities");
const Auth = require("../middleware/Auth");

// API:GET /post/:id
router.get("/:id", Auth, async (req, res) => {
  //   console.log(req.query);
  try {
    let postId = req.params.id;
    if (postId < 0 || isNaN(postId)) {
      throw new Error("404 not found");
    }
    let queryFieldsPost =
      "posts.post_id AS postId,posts.user_id AS userId, avatar, content, likes, comments, time, name, users.blue_tick AS blueTick, images.link AS image";
    let sqlPost = `SELECT ${queryFieldsPost} FROM posts JOIN users ON posts.user_id = users.user_id LEFT JOIN images ON posts.post_id = images.post_id WHERE posts.post_id = ${postId} `; //AND posts.deleted = 0
    mysql.db.query(sqlPost, function (error, postData, fields) {
      if (error) throw error;
      if (postData[0]) {
        // query comments
        if (postData[0].comments) {
          let sqlCmt = `SELECT cmt_id AS cmtId, cmt_content AS cmtContent, user_id AS userCmtId, time AS cmtTime FROM comment_table WHERE post_id = ${postId} AND deleted = 0`; // AND deleted = 0
          mysql.db.query(sqlCmt, (error, cmtArr, fields) => {
            if (error) throw error;
            res.json({
              success: true,
              postData: postData[0],
              allComments: cmtArr,
            });
          });
        }
      } else {
        res.json({
          success: false,
          message: "404 not found",
        });
      }
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
  try {
    let postId = req.params.id;
    let comment = req.body.comment;
    let userId = req.userId; // userId comments at postId with data

    let sqlInsertCmt = `INSERT INTO comment_table (cmt_content, post_id, user_id) VALUES (${mysql.db.escape(
      comment
    )}, '${postId}', '${userId}')`;

    mysql.db.query(sqlInsertCmt, function (error, result) {
      if (error) throw error;
      res.json({
        success: true,
        message: "Comment successfull",
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
