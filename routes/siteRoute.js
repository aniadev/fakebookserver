const express = require("express");
const router = express.Router();

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

module.exports = router;
