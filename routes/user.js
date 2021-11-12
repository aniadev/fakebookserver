const express = require("express");
const router = express.Router();
const mysql = require("../config/mysql");
const Auth = require("../middleware/Auth");

// https://fakebook.com:8080/user/
router.get("/", Auth, async (req, res) => {
  let userId = parseInt(req.query._id, 10);
  // console.log(parseInt(userId, 10));
  if (userId) {
    try {
      // const queryFields = "user_id, name, username, avatar, email";
      const sql = `SELECT user_id, name, username, avatar, email, birthday, address, cover_photo, blue_tick FROM fastbook.users WHERE user_id = ${userId}`;
      // console.log(sql);
      mysql.db.query(sql, function (err, result) {
        if (err) throw err;
        // console.log(result);
        if (!result[0]) {
          return res.json({
            success: false,
            message: "No data",
          });
        }
        let userData = {
          userId: result[0].user_id,
          name: result[0].name,
          username: result[0].username,
          email: result[0].email,
          avatar: result[0].avatar,
          birthday: result[0].birthday,
          address: result[0].address,
          coverPhoto: result[0].cover_photo,
          blueTick: result[0].blue_tick,
        };
        res.json({
          success: true,
          userData,
        });
      });
    } catch (error) {
      res.json({
        success: false,
        message: error.message,
      });
    }
  } else {
    res.json({
      success: false,
      message: "userAPI/profile: not enough query fields",
    });
  }
});

// https://fakebook.com:8080/user/posts
router.get("/posts", Auth, async (req, res) => {
  let userId = parseInt(req.query._id, 10);
  // console.log(parseInt(userId, 10));
  if (userId) {
    try {
      const queryFields =
        "posts.post_id AS postId, posts.user_id AS userId, content, likes, comments, time, images.link AS image";
      const sql = `SELECT ${queryFields} FROM posts LEFT JOIN images ON posts.post_id = images.post_id WHERE posts.user_id = ${userId} AND posts.deleted = 0 ORDER BY time DESC`;
      // console.log(sql);
      mysql.db.query(sql, function (err, result) {
        if (err) throw err;
        if (result) {
          res.json({
            success: true,
            posts: result,
          });
        }
      });
    } catch (error) {
      res.json({
        success: false,
        message: error.message,
      });
    }
  } else {
    res.json({
      success: false,
      message: "userAPI/posts: not enough query fields",
    });
  }
});

// https://fakebook.com:8080/user/posts
router.post("/avatar", Auth, async (req, res) => {
  try {
    let data = req.body;
    let userId = req.userId;
    let avatar = data.avatarLink;
    let content = "Đã cập nhật ảnh đại diện.";
    // update avatar
    let sqlAvatar = `UPDATE users SET avatar = '${avatar}' WHERE user_id = ${userId}`; // Callback helllllllllllllll
    mysql.db.query(sqlAvatar, function (error, result) {
      if (error) throw error;
      if (result) {
        // create post
        let sqlPost = `INSERT INTO posts (user_id, content) VALUES ('${userId}', '${content}')`;
        mysql.db.query(sqlPost, function (error, result) {
          if (error) throw error;
          // console.log(result);
          let sqlImg = `INSERT INTO images (link, post_id) VALUES ('${avatar}', '${result.insertId}')`;
          mysql.db.query(sqlImg, function (error, result) {
            if (error) throw error;
            if (result) {
              res.json({
                success: true,
                message: "update avatar successful",
                postCreated: {
                  postId: result.insertId,
                  userId: req.userId,
                  content,
                  imageLinks: avatar,
                },
              });
            }
          });
        });
      }
    });
  } catch (error) {
    console.log("🚀 ~ file: user.js ~ line 124 ~ router.post ~ error", error);
  }
});

module.exports = router;
