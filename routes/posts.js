const express = require("express");
const router = express.Router();
const mysql = require("../config/mysql");
const htmlEntities = require("html-entities");

// API:GET /posts
router.get("/", async (req, res) => {
  //   console.log(req.query);
  const limit = req.query._limit || 10;
  const offset = req.query._offset || 0;
  const queryFields =
    "posts.post_id AS postId,posts.user_id AS userId, avatar, content, likes, comments, time, name, images.link AS image";
  const sql = `SELECT ${queryFields} FROM posts JOIN users ON posts.user_id = users.user_id LEFT JOIN images ON posts.post_id = images.post_id WHERE posts.deleted = 0 LIMIT ${limit} OFFSET ${offset}`;
  await mysql.db.query(sql, function (err, postList, fields) {
    if (err) throw err;
    res.json({
      success: true,
      posts: postList,
    });
  });
});

// API:POST /posts/create
router.post("/create", async (req, res) => {
  var data = req.body;
  var userId = data.userId;
  var content = htmlEntities.encode(data.content, {
    mode: "nonAsciiPrintable",
  });
  var images = data.imageLinks;
  // console.log(content);
  var sqlPost = `INSERT INTO posts (user_id, content) VALUES ('${userId}', '${content}')`;
  // const sqlImg = `INSERT INTO images (link, post_id) VALUES ('${data.images}', '${result.insert_id}')`;

  const savePost = new Promise((resolve, reject) => {
    mysql.db.query(sqlPost, function (err, result) {
      if (err) reject(err);
      resolve(result);
    });
  });
  savePost
    .then((result) => {
      var sqlImg = `INSERT INTO images (link, post_id) VALUES ('${images}', '${result.insertId}')`;
      if (images) {
        mysql.db.query(sqlImg, function (err, result) {
          if (err) reject(err);
          res.json({
            success: true,
            message: "create post successful",
          });
        });
      }
    })
    .catch((err) => {
      console.log("🚀 ~ file: posts.js ~ line 53 ~ router.post ~ err", err);
    });

  //   {
  //     user: {
  //       userId: 1,
  //       name: 'Phạm Công Hải',
  //       avatar: 'https://i.ibb.co/H4WHmsn/default-avatar.png'
  //     },
  //     content: { value: 'hello', image: null, time: 1634812951855 }
  //   }
});

module.exports = router;
