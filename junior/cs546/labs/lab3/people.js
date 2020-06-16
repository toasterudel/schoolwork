/*
*   Christopher Rudel
*   CS546
*   people.js
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const axios = require('axios');


async function getPeople(){
    const {data} = await axios.get('https://gist.githubusercontent.com/robherley/5112d73f5c69a632ef3ae9b7b3073f78/raw/24a7e1453e65a26a8aa12cd0fb266ed9679816aa/people.json');
    return data;
}

const getPersonById = async function getPersonById(id){
    if(id === undefined || id === null || typeof id != "number"){
        throw "Error: please ensure the argument is a number for function getPersonById";
    }
    
    let names = "";

    let people = await getPeople();

    if(id > people.length || id < 1){
        throw "Error: provided id is not within the bounds of the list of people";
    }
    people.forEach(person => {
        if(person["id"] == id){
            names = names.concat(person["firstName"], " ", person["lastName"]);
        }
    });
    return names;

}

const lexIndex = async function lexIndex(index){
    if(index === undefined || index === null || typeof index != "number"){
        throw "Error: please ensure the argument is a number for function lexIndex";
    }

    let people = await getPeople();
    if(index >= people.length || index < 0){
        throw "Error: provided index is not within the bounds of the list of people";
    }

    let lastNames = [];
    let retMe = "";
    people.forEach(person =>{
        lastNames.push(person["lastName"]);
    });
    lastNames = lastNames.sort();
    people.forEach(person =>{
        if(person["lastName"] == lastNames[index]){
            retMe = person["firstName"] + " " + person["lastName"];
        }

    });
    return retMe;
}

const firstNameMetrics = async function firstNameMetrics(){

    let people = await getPeople();

    let totalLetters = 0;
    let totalVowels = 0;
    let totalConsonants = 0;
    let longestName = people[0]["firstName"];
    let shortestName = people[0]["firstName"];

    let vowels = ['a','e','i','o','u'];

    people.forEach(person =>{
        let fName = person["firstName"];
        totalLetters += fName.length;
        if(fName.length > longestName.length){
            longestName = fName;
        } else if(fName.length < shortestName.length){
            shortestName = fName;
        }
        fName = fName.toLowerCase();
        for(let i=0; i<fName.length; i++){
            if(vowels.includes(fName.charAt(i))){
                totalVowels++;
            }else{
                totalConsonants++;
            }
        }

    });
    let retObject = {
        "totalLetters" : totalLetters,
        "totalVowels" : totalVowels,
        "totalConsonants" : totalConsonants,
        "longestName" : longestName,
        "shortestName" : shortestName
    };
   
    return retObject;
}



module.exports = {
    firstName: "Christopher",
    lastName: "Rudel",
    studentId: "10413032",
    getPersonById,
    lexIndex,
    firstNameMetrics
}