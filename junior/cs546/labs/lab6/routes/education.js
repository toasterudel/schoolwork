/*
*   Christopher Rudel
*   CS546
*   education.js
*   lab6
*   I pledge my honor that I have abided by the Stevens Honor System
*/
const express = require('express');
const router = express.Router();

const education = [
    {
    "schoolName": "Stevens Institute of Technology",
    "degree" : "Bachelor's of Science",
    "favoriteClass" : "HLI 221 Introduction to Cinema",
    "favoriteMemory" : "Going to Chelsea Piers for laser tag with my friends"
    },
    {
    "schoolName": "Sparta High School",
    "degree" : "High School Diploma",
    "favoriteClass" : "Sophomore Year Intro to Programming",
    "favoriteMemory" : "My friend making a mess all over with a packet of pudding he was eating"
    },
    {
    "schoolName": "Sparta Middle School",
    "degree" : "Middle School Diploma",
    "favoriteClass" : "Eight grade math",
    "favoriteMemory" : "Playing cards with friends during lunch"
    }
];

router.get("/", (req, res) =>{
    try{
        res.json(education);
    }catch(error){
        res.status(500).send('Server error: ' + error)
    }
});

module.exports = router;