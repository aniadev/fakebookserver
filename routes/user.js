const express = require("express");
const router = express.Router();
const mysql = require("../config/mysql");
const Auth = require("../middleware/Auth");

// https://fakebook.com:8080/user/
router.get("/", Auth, async (req, res) => {
  res.json({
    success: true,
    message: "userAPI",
  });
});

module.exports = router;
