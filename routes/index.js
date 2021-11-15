const auth = require("./auth");
const posts = require("./posts");
const user = require("./user");
const siteRoute = require("./siteRoute");
const post = require("./post");

route = (app) => {
  //use routes
  app.use("/auth", auth);
  app.use("/posts", posts);
  app.use("/post", post);
  app.use("/user", user);
  app.use("/", siteRoute);
};

module.exports = route;
