/*
*   Christopher Rudel
*   CS546
*   index.js
*   lab6
*   I pledge my honor that I have abided by the Stevens Honor System
*/
const aboutRoute = require("./about");
const storyRoute = require("./story");
const eduRoute = require("./education");

const constructorMethod = app =>{
    app.use("/about", aboutRoute);
    app.use("/story", storyRoute);
    app.use("/education", eduRoute);

    app.use("*", (req, res) => {
        res.status(404).json({error: "Not found"});
    });
};

module.exports = constructorMethod;