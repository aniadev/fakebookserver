const express = require("express");
const router = express.Router();

// https://fakebook.com:8080/api/
router.get("/", (req, res) => {
  res.json({ success: true, method: "GET" });
});
module.exports = router;
