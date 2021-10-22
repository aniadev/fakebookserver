const express = require("express");
const cors = require("cors");
// import mysql
const mysql = require("./config/mysql");
mysql.connect();

// import Route
const Route = require("./routes");

const app = express();
// parse application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: false }));
// parse application/json
app.use(express.json());
app.use(cors());
Route(app);

app.listen(process.env.PORT || 8080, () =>
  console.log(`Example app listening on port ${process.env.PORT || 8080}!`)
);
