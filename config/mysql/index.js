// import mysql
const mysql = require("mysql");
require("dotenv").config();

const db = mysql.createConnection({
  host: process.env.MYSQL_DB_HOST,
  user: process.env.MYSQL_DB_USERNAME,
  password: process.env.MYSQL_DB_PASSWORD,
  database: process.env.MYSQL_DB_NAME,
});

async function connect() {
  try {
    db.connect((err) => {
      if (err) {
        console.log("🚀 ~ file: index.js ~ line 16 ~ db.connect ~ err", err);
        return;
      } else {
        console.log("Connected!");
      }
    });
  } catch (error) {
    console.log("Error connecting mysql: " + error);
  }
}
module.exports = { connect, db };
