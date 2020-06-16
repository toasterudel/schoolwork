/*
*   Christopher Rudel
*   CS546
*   app.js
*   I pledge my honor that I have abided by the Stevens Honor System
*/


const people = require("./people");
const weather = require("./weather");
const work = require("./work");

const start = async function start(){
    try{
        const lex = await people.lexIndex(46);
        console.log(lex);

    }catch(error){
        console.error(error);
    }
    try{
        const outside = await weather.shouldTheyGoOutside("Rogerio", "Outibridge");
        console.log(outside);        

    }catch(error){
        console.error(error);
    }
    try{
        const hacker = await work.findTheHacker("227.2.76.54");
        console.log(hacker);
    }catch(error){
        console.error(error);
    }
}
start();
