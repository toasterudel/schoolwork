/*
*   Christopher Rudel
*   CS546
*   about.js
*   lab6
*   I pledge my honor that I have abided by the Stevens Honor System
*/
const express = require('express')
const router = express.Router()

const about = {
    "name" : "Christopher Rudel",
    "cwid" : "10413032",
    "biography" : `My name is Chris Rudel, I grew up in a small town in North West New Jersey. I had hard working parents that always 
    wanted me to be involved physically. As a kid I would play many sports and somehow my parents would shuttle me along to each sport 
    without much complaining. Eventually I narrowed down my sports to a sport, swimming.\nI wasn’t particularly great at any one sport, but 
    I was better at swimming than the other sports that I did. I wasn’t really sure what I wanted to do for a career for a long time. I 
    always knew that I was good at math growing up but it didn’t particularly interest me so I held off saying that I wanted to go into the
     world of math. In my sophomore year I was introduced to coding through a class that I took and I got interested in coding. There 
     was a lot to learn but I was eager to make cool things that I could show to my friends and challenge myself in an exciting way. 
     I still have a lot to learn.`,

    "favoriteShows" : ["Parks and Rec", "Nathan for You", "Arrested Development", "Black Mirror", "The Office"],
    "hobbies" : ["Coding", "Playing Video Games", "Swimming", "Running"]
};

router.get("/", (req, res) => {
    try{
        res.json(about);
    }catch(error){
        res.status(500).send('Server Error: ' + error);
    }
});

module.exports = router;