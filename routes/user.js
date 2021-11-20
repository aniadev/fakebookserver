const express = require("express");
const router = express.Router();
const mysql = require("../config/mysql");
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

// https://fakebook.com:8080/user?_id=2
router.get("/", Auth, async (req, res) => {
  try {
    let userId = req.query._id;
    if (isNaN(userId) || !userId) {
      throw Error("User ID invalid");
    }
    const sql = `SELECT user_id, name, username, avatar, email, birthday, address, cover_photo, blue_tick FROM fastbook.users WHERE user_id = ${userId}`;
    sqlQuery(sql)
      .then((result) => {
        if (result[0]) {
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
        } else {
          throw Error("404 not found");
        }
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

// https://fakebook.com:8080/user/posts
router.get("/posts", Auth, async (req, res) => {
  try {
    let userId = req.query._id;
    if (isNaN(userId) || !userId) {
      throw Error("User ID invalid");
    }
    const queryFields =
      "posts.post_id AS postId, posts.user_id AS userId, content, likes, comments, posts.time, images.link AS image, like_table.like_id AS likeId";
    const sql = `SELECT ${queryFields} FROM posts LEFT JOIN images ON posts.post_id = images.post_id LEFT JOIN like_table ON like_table.user_id = ${userId} AND like_table.post_id = posts.post_id WHERE posts.user_id = ${userId} AND posts.deleted = 0 ORDER BY time DESC`;
    sqlQuery(sql)
      .then((results) => {
        res.json({
          success: true,
          posts: results,
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

// https://fakebook.com:8080/user/avatar
router.post("/avatar", Auth, (req, res) => {
  try {
    let data = req.body;
    let userId = req.userId;
    let avatar = data.avatarLink;
    if (!avatar) {
      throw Error("Avatar Link invalid");
    }
    let content = "Đã cập nhật ảnh đại diện.";
    // update avatar
    let sqlAvatar = `UPDATE users SET avatar = ${mysql.db.escape(
      avatar
    )} WHERE user_id = ${userId}`;
    let postId;
    sqlQuery(sqlAvatar) // update avatar
      .then(() => {
        // create post
        let sqlPost = `INSERT INTO posts (user_id, content) VALUES ('${userId}', '${content}')`;
        return sqlQuery(sqlPost);
      })
      .then((sqlPostResult) => {
        postId = sqlPostResult.insertId;
        let sqlImg = `INSERT INTO images (link, post_id) VALUES ('${avatar}', '${postId}')`;
        return sqlQuery(sqlImg);
      })
      .then(() => {
        res.json({
          success: true,
          message: "update avatar successful",
          postCreated: {
            postId: postId,
            userId: req.userId,
            content,
            imageLinks: mysql.db.escape(avatar),
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

module.exports = router;
