/*
*   Christopher Rudel
*   CS546
*   weather.js
*   I pledge my honor that I have abided by the Stevens Honor System
*/
const axios = require('axios');

async function getPeople(){
    const {data} = await axios.get('https://gist.githubusercontent.com/robherley/5112d73f5c69a632ef3ae9b7b3073f78/raw/24a7e1453e65a26a8aa12cd0fb266ed9679816aa/people.json');
    return data;
}
async function getWeather(){
    const {data} = await axios.get('https://gist.githubusercontent.com/robherley/1b950dc4fbe9d5209de4a0be7d503801/raw/eee79bf85970b8b2b80771a66182aa488f1d7f29/weather.json');
    return data;
}

const shouldTheyGoOutside = async function shouldTheyGoOutside(firstName, lastName){
    if(firstName === undefined || firstName === null || typeof firstName != "string"){
        throw "Error: ensure the first argument of function shouldTheyGoOutside is a string";
    }
    if(lastName === undefined || lastName === null || typeof lastName != "string"){
        throw "Error: ensure the second argument of function shouldTheyGoOutside is a string";
    }
    let people = await getPeople();
    let weather = await getWeather();
    let index = -1;
    for(let i=0; i<people.length; i++){
        if(people[i]["firstName"] == firstName && people[i]["lastName"] == lastName){
            index = i;
        }
    }
    if(index == -1){
        throw "Error: person that was input does not exist!";
    }
    let zip = people[index]["zip"];
    let outside = false;
    weather.forEach(place =>{
        if(place["zip"] == zip && place["temp"] >= 34){
            outside = true;
        }
    });

    if(outside){
        return `Yes, ${firstName} should go outside.`;
    }else{
        return `No, ${firstName} should not go outside.`;
    }
}



module.exports = {
    firstName: "Christopher",
    lastName: "Rudel",
    studentId: "10413032",
    shouldTheyGoOutside
}