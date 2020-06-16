/*
*   Christopher Rudel
*   CS546
*   work.js
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const axios = require('axios');

async function getPeople(){
    const {data} = await axios.get('https://gist.githubusercontent.com/robherley/5112d73f5c69a632ef3ae9b7b3073f78/raw/24a7e1453e65a26a8aa12cd0fb266ed9679816aa/people.json');
    return data;
}
async function getWork(){
    const {data} = await axios.get('https://gist.githubusercontent.com/robherley/61d560338443ba2a01cde3ad0cac6492/raw/8ea1be9d6adebd4bfd6cf4cc6b02ad8c5b1ca751/work.json');
    return data;
}

const whereDoTheyWork = async function whereDoTheyWork(firstName, lastName){
    if(firstName === undefined || firstName === null || typeof firstName != "string"){
        throw "Error: ensure the first argument of function whereDoTheyWork is a string";
    }
    if(lastName === undefined || lastName === null || typeof lastName != "string"){
        throw "Error: ensure the second argument of function whereDoTheyWork is a string";
    }

    let people = await getPeople();
    let work = await getWork();
    let index = -1;
    for(let i=0; i<people.length; i++){
        if(people[i]["firstName"] == firstName && people[i]["lastName"] == lastName){
            index = i;
        }
    }
    if(index == -1){
        throw "Error: person that was input does not exist!";
    }
    let ssn = people[index]["ssn"];
    let job = "";
    let place = "";
    let fired = false;
    work.forEach(person =>{
        if(person["ssn"] == ssn){
            job = person["jobTitle"];
            place = person["company"];
            fired = person["willBeFired"];
        }
    });
    if(fired){
        return `${firstName} ${lastName} - ${job} at ${place}. They will be fired.`;
    }else{
        return `${firstName} ${lastName} - ${job} at ${place}. They will not be fired.`;
    }

}


const findTheHacker = async function findTheHacker(ip){
    if(ip === undefined || ip === null || typeof ip != "string"){
        throw "Error: ensure the first argument of function findTheHacker is a string";
    }

    let people = await getPeople();
    let work = await getWork();

    let ssn = "";
    for(let i=0; i<work.length; i++){
        if(work[i]["ip"] == ip){
            ssn = work[i]["ssn"];
        }
    }
    if(ssn == ""){
        throw "Error: hacker was not found, does not exist in work database.";
    }
    let hacker = "";
    people.forEach(person =>{
        if(person["ssn"] == ssn){
            hacker = hacker.concat(person["firstName"], " ", person["lastName"]);
        }
    });
    return `${hacker} is the hacker!`;
}

module.exports = {
    firstName: "Christopher",
    lastName: "Rudel",
    studentId: "10413032",
    whereDoTheyWork,
    findTheHacker
}