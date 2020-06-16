const express = require("express");
const router = express.Router();
const data = require("../data");
const mainData = data.main;

router.get("/:id", async (req,res) =>{
    try{
        const person = await mainData.getPersonById(parseInt(req.params.id));
        let obj = {person: person, titlePage: "Person Found"};
        res.render('layouts/main', obj);
    }catch(e){
        res.statusCode = 400;
        res.render('layouts/main', {title: e});
    }
});

router.get("/", async (req,res) =>{
    res.status = 500;
    res.render('layouts/main', {title: 'No id input when requesting GET from /details/id'});
})

module.exports = router;