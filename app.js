const express = require("express");
const cors = require("cors");

const authRouter = require("./routes/auth");

const db = require("./config/db");
db.connect();

const app = express();
// parse application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: false }));
// parse application/json
app.use(express.json());
app.use(cors());
app.use("/api", authRouter);

app.listen(process.env.PORT || 5000, () =>
  console.log(`Example app listening on port ${process.env.PORT || 5000}!`)
);
