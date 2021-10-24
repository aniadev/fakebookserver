var jwt = require("jsonwebtoken");
require("dotenv").config();

Auth = (req, res, next) => {
  console.log(req.headers.authorization);
  next();
};

module.exports = Auth;
