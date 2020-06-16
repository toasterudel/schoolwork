const express = require("express");
const router = express.Router();
const data = require("../data");
const mainData = data.main;


router.post("/", async (req, res) =>{
    let searchBody = req.body;
    let errors = [];
    if(!searchBody.firstName && !searchBody.lastName){
        errors.push("No first or last name");
    }
    let people;
    try{
        if(searchBody.firstName && searchBody.lastName){
            people = await mainData.getPersonByFullName(searchBody.firstName,searchBody.lastName);
        }
        else if(searchBody.lastName){
            people = await mainData.getPersonByLastName(searchBody.lastName);
        }
        else if(searchBody.firstName){
            
            people = await mainData.getPersonByFirstName(searchBody.firstName);
        }
        res.render('layouts/main', {personName: searchBody.firstName + " " + searchBody.lastName, people: people, titlePage: "People Found"});
    }catch(e){
        res.status = 500;
        res.render('layouts/main', {title: e});
    }
})

router.get("/", async (req,res) =>{
    res.status = 500;
    res.render('layouts/main', {title: 'Should only be trying to POST from search, not GET'});
})


module.exports = router;
