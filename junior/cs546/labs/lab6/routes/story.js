/*
*   Christopher Rudel
*   CS546
*   story.js
*   lab6
*   I pledge my honor that I have abided by the Stevens Honor System
*/
const express = require('express');
const router = express.Router();

const story = {
    "storyTitle" : "Breakdown",
    "story" : `On the way home from our championship swim meet, our bus broke down unexpectedly. We all wanted to go
     home so that we could continue to catch up on the week’s worth of school we just missed, but we also didn’t want
      to make the situtation worse by complaining to each other. At first I was having a pretty good time talking to
       my friends to try to pass the time, but after a while conversation got stale and I just wanted to be home.\nAfter 
       a little while the backup bus was able to arrive and we were able to switch to it and made it home around 3 am. 
       Many people were not happy and a few of the people reached out to their professors asking to take a makeup test
        later because of how late we got back. That was the only time we’ve ever had a serious bus problem, and hopefully 
        (knock on wood) the last. `
};

router.get("/", (req, res) => {
    try{
        res.json(story);
    }catch(error){
        res.status(500).send('Server error: ' + error);
    }
});

module.exports = router;