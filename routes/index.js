const auth = require("./auth");
const posts = require("./posts");
const user = require("./user");
const siteRoute = require("./siteRoute");

route = (app) => {
  //use routes
  app.use("/auth", auth);
  app.use("/posts", posts);
  app.use("/user", user);
  app.use("/", siteRoute);
};

module.exports = route;
