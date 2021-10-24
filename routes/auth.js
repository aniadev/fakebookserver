const express = require("express");
const router = express.Router();
const mysql = require("../config/mysql");
const jwt = require("jsonwebtoken");
const SECRET_KEY = process.env.ACCESS_TOKEN_SECRET;

// https://fakebook.com:8080/auth/
router.post("/", async (req, res) => {
  const [type, accessToken] = [...req.headers.authorization.split(" ")];
  try {
    let jwt_decoded = jwt.verify(accessToken, SECRET_KEY);
    // console.log(jwt_decoded);
    const queryFields = "user_id, username, name, email, avatar";
    await mysql.db.query(
      `SELECT ${queryFields} FROM users WHERE username = '${jwt_decoded.username}'`,
      function (error, result, fields) {
        if (error) console.log("Query error: " + error);
        const userData = {
          userId: result[0].user_id,
          username: result[0].username,
          name: result[0].name,
          avatar: result[0].avatar,
          email: result[0].email,
        };
        let accessToken = jwt.sign(userData, SECRET_KEY);
        res.json({
          success: true,
          method: "POST",
          message: "authenticated",
          userData,
          accessToken,
        });
      }
    );
  } catch (error) {
    console.log("Parse error: " + error);
    res.json({
      success: false,
      method: "POST",
      message: "invalid token",
    });
  }
});

// https://fakebook.com:8080/auth/login
router.post("/login", async (req, res) => {
  const { username, password } = req.body;
  // console.log({ username, password });
  const queryFields = "user_id, username, name, avatar, email";
  await mysql.db.query(
    `SELECT ${queryFields} FROM users WHERE username = '${username}' AND password = '${password}'`,
    function (err, result, fields) {
      if (err) throw err;
      // console.log();
      if (result[0]) {
        // let accessToken = "Bearer adsada";
        const userData = {
          userId: result[0].user_id,
          username: result[0].username,
          name: result[0].name,
          avatar: result[0].avatar,
          email: result[0].email,
        };
        let accessToken = jwt.sign(userData, SECRET_KEY);
        res.json({
          success: true,
          message: "login successful",
          accessToken,
          type: "Bearer",
          userData,
        });
      } else {
        res.json({
          success: false,
          message: "wrong username or password",
        });
      }
    }
  );
});

// https://fakebook.com:8080/auth/register
router.post("/register", async (req, res) => {
  const regData = req.body;
  const { username, password, name, email } = regData;
  const queryFields = "username";
  if (!username || !password || !name) {
    res.json({
      success: false,
      message: "invalid fields",
    });
  } else {
    await mysql.db.query(
      `SELECT ${queryFields} FROM users WHERE username = '${username}'`,
      function (err, userData, fields) {
        if (err) throw err;
        // console.log();
        if (!userData[0]) {
          var sql = `INSERT INTO users (name, username, email, password) VALUES ('${name}', '${username}','${email}','${password}')`;
          mysql.db.query(sql, function (err, result) {
            if (err) throw err;
            res.json({
              success: true,
              message: "register successful",
            });
          });
        } else {
          res.json({
            success: false,
            message: "invalid username",
          });
        }
      }
    );
  }
});

module.exports = router;
