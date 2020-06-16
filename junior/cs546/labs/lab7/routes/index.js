/*
*   Christopher Rudel
*   CS546
*   index.js
*   lab7
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const animalRoutes = require("./animals");
const postRoutes = require("./posts");

const constructorMethod = app => {
    app.use("/posts", postRoutes);
    app.use("/animals", animalRoutes);

    app.use("*", (req,res) => {
        res.sendStatus(404);
    });
};

module.exports = constructorMethod;