const express = require("express");
const router = express.Router();
const users = require("../data/users");
const auth = require("../middleware/auth");

router.get("/", (req,res) =>{
    if(req.cookies.name === "AuthCookie") {
        res.redirect("/private");
    }else{
        let str = new Date().toUTCString();
        str = str.concat(" ");
        str = str.concat(req.method);
        str = str.concat(" ");
        str = str.concat(req.originalUrl);
        str = str.concat(" ");
        str = str.concat("(Non-Authenticated User)");
        console.log(str);
        /* I'm doing the above because he wanted us to have the request route, meaning
            that it would show up for /, /login and /private */
        res.render("users/home", { title: "Welcome to the login screen"});
    }
});

router.post("/login", async (req, res) =>{
    let userN = req.body.username;
    let passW = req.body.password;

    if(userN && passW){
        uResult = users.checkUsername(userN);
        pResult = await users.checkPassword(userN, passW);
        if(uResult && pResult.status){
            let {_id, username, firstName, lastName, Profession, Bio} = pResult.user;
            res.cookie("name", "AuthCookie");
            let user = {_id, username, firstName, lastName, Profession, Bio};
            req.session.user = user;
            res.redirect("/private");
        }else{
            res.render("users/home", {
                title: "Welcome to the login page",
                message: "Wrong username or password",
                status: false
            });
        }
    } else{
        res.render("users/home", {
            title: "Welcome to the login page",
            message: "No username or password provided",
            status: false
        });
    } 
});

router.get("/private", auth, (req, res) => {
    let user = req.session.user;
    if(user){
        res.render("users/info",
        {
            user,
            title: `Welcome ${user.firstName} ${user.lastName}`
        });
    }else{
        res.render("users/home", { title: "Welcome to the login page"});
    }
});

router.get("/logout", (req,res) =>{
    res.clearCookie('name');
    res.redirect("/");
})


module.exports = router;