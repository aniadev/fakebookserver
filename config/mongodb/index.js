const mongoose = require("mongoose");
require("dotenv").config();

const mongodb_uri = `mongodb+srv://${process.env.MONGO_DB_USERNAME}:${process.env.MONGO_DB_PASSWORD}@cluster0.2vvnb.mongodb.net/${process.env.MONGO_DB_NAME}?retryWrites=true&w=majority`;
// const mongodb_uri = 'mongodb://localhost:27017/appjs_dev';
// const uri = process.env.MONGODB_URI //Config from heroku var
async function connect() {
  try {
    await mongoose.connect(mongodb_uri, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log("Connect MongoDB Successfully");
  } catch (err) {
    console.log(err.message);
  }
}

module.exports = { connect };
