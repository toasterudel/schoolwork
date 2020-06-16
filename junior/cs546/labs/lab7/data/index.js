/*
*   Christopher Rudel
*   CS546
*   index.js
*   lab7
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const animalData = require("./animals");
const postData = require("./posts");
const likeData = require("./likes");

module.exports = {
    animals: animalData,
    posts: postData,
    likes: likeData
}