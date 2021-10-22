const express = require("express");
const router = express.Router();
const mysql = require("../config/mysql");
const htmlEntities = require("html-entities");

// API:GET /posts
router.get("/", async (req, res) => {
  //   console.log(req.query);
  const queryFields =
    "posts.post_id AS postId,posts.user_id AS userId, avatar, content, likes, comments, time, name, images.link AS image";
  const sql = `SELECT ${queryFields} FROM posts JOIN users ON posts.user_id = users.user_id LEFT JOIN images ON posts.post_id = images.post_id WHERE posts.deleted = 0`;
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
  let data = req.body;
  let userId = data.userId;
  let content = htmlEntities.encode(data.content, {
    mode: "nonAsciiPrintable",
  });
  let images = data.images;
  // console.log(content);
  var sql = `INSERT INTO posts (user_id, content) VALUES ('${userId}', '${content}')`;
  await mysql.db.query(sql, function (err, result) {
    if (err) throw err;
    // console.log(result);
    res.json({
      success: true,
      message: "post created successfully",
    });
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
