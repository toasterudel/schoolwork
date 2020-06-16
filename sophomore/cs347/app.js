/**
 * Created by avi on 4/3/18.
 */
const express = require("express")
const app = express()
const bodyParser = require("body-parser");
const exphbs = require("express-handlebars");
const exps = require('express-session');
const configRoutes = require("./routes")

app.use("/public",express.static(__dirname+ "/public"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(exps({ secret: 'keyboard cat', resave: false, saveUninitialized: false }));

configRoutes(app)

app.listen(3000, function() {
    console.log('Your server is now listening on port 3000! Navigate to http://localhost:3000 to access it');
})

