const express = require("express");
const session = require('express-session');
const bodyParser = require("body-parser");
const cookie = require("cookie-parser");
const app = express();
const static = express.static(__dirname + "/public");
const configRoutes = require("./routes");
const exphbs = require("express-handlebars");
const handlebars = require("handlebars");

const handlebarsInstance = exphbs.create({
    defaultLayout: "main",
    // Specify helpers which are only registered on this instance.
    helpers: {
        asJSON: (obj, spacing) => {
            if(typeof spacing === "number")
                return new handlebars.SafeString(JSON.stringify(obj, null, spacing));

            return new handlebars.SafeString(JSON.stringify(obj));
        }
    }
});

const rewriteUnsupportedBrowserMethods = (req, res, next) => {
    // If the user posts to the server with a property called _method, rewrite the request's method
    // To be that method; so if they post _method=PUT you can now allow browsers to POST to a route that gets
    // rewritten in this middleware to a PUT route
    if (req.body && req.body._method) {
      req.method = req.body._method;
      delete req.body._method;
    }
    // let the next middleware run:
    next();
  };
  

app.use("/", static);
app.use(cookie());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true}));
app.use(rewriteUnsupportedBrowserMethods);
app.use(session({
    name: 'AuthCookie',
    secret: 'club penguin',
    resave: false,
    saveUninitialized: true,
    cookie: {secure: false}
}));

app.engine("handlebars", handlebarsInstance.engine);
app.set("view engine", "handlebars");


configRoutes(app);

app.listen(3000, () => {
    console.log("We've now got a server!");
    console.log("Your routes will be running on http://localhost:3000");
  });


