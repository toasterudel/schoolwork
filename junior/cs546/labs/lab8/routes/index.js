const searchRoutes = require("./search");
const detailRoutes = require("./details");
//const mainRoutes = require("./main");
const path = require("path");

const constructorMethod = app => {
    app.use("/search", searchRoutes);
    app.use("/details", detailRoutes);

    app.use("/", (req, res) =>{
        let route = path.resolve('static/about.html');
        res.sendFile(route);
    });

    app.use("*", (req, res) => {
        res.status(404).json({error: "Not found"});
    });
}

module.exports = constructorMethod;