// import mysql
const mysql = require("mysql");
require("dotenv").config();

const db = mysql.createConnection({
  host: "localhost",
  user: process.env.MYSQL_DB_USERNAME,
  password: process.env.MYSQL_DB_PASSWORD,
  database: process.env.MYSQL_DB_NAME,
});

async function connect() {
  try {
    db.connect((err) => {
      if (err) {
        console.log(err);
      } else {
        console.log("Connected!");
      }
    });
  } catch (error) {
    console.log("Error connecting mysql: " + error);
  }
}
module.exports = { connect, db };
