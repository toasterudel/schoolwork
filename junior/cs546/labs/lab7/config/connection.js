/*
*   Christopher Rudel
*   CS546
*   connection.js
*   lab7
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const MongoClient = require("mongodb").MongoClient;
const settings = {
  mongoConfig: {
    serverUrl: "mongodb://localhost:27017/",
    database: "Christopher_Rudel_lab7"
  }
};
const mongoConfig = settings.mongoConfig;

let _connection = undefined;
let _db = undefined;

module.exports = async () => {
  if (!_connection) {
    _connection = await MongoClient.connect(mongoConfig.serverUrl, {useNewUrlParser: true});
    _db = await _connection.db(mongoConfig.database);
  }

  return _db;
};
