const authUser = function authUser(req, res, next) {
    let str = new Date().toUTCString();
    str = str.concat(" ");
    str = str.concat(req.method);
    str = str.concat(" ");
    str = str.concat(req.originalUrl);
    str = str.concat(" ");
    if(req.cookies.name === 'AuthCookie'){
        str = str.concat("(Authenticated User)");
        console.log(str);
        /*If the user is logged in, the middleware will "fall through" to the next route calling the next() callback. */
        next();
    }else{
        str = str.concat("(Non-Authenticated User)");
        console.log(str);
        /* If a user is not logged in, you will return an HTML page saying that the user is not logged in, and the page must issue an HTTP status code of 403. */
        res.status(403).render("users/error", {title: "Error: Not allowed"});
    }
}

module.exports = authUser;