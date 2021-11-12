const express = require("express");
const router = express.Router();

// localhost:8080
router.get("/", (req, res) => {
  res.json({
    success: true,
    message: "restAPI server",
    api: {
      login: "/auth/login",
      register: "/auth/register",
      get_posts: "/posts",
    },
  });
});

router.get("/test", (req, res) => {
  setTimeout(() => {
    res.json({
      success: true,
      message: "test",
      timeout: "5000 ms",
    });
  }, 5000);
});

module.exports = router;
