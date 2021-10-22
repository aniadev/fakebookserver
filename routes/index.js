const auth = require("./auth");
const posts = require("./posts");
const siteRoute = require("./siteRoute");

route = (app) => {
  //use routes
  app.use("/auth", auth);
  app.use("/posts", posts);
  app.use("/", siteRoute);
};

module.exports = route;
