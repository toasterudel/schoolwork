

const axios = require('axios');

async function getPeople(){
    const {data} = await axios.get("https://gist.githubusercontent.com/robherley/5112d73f5c69a632ef3ae9b7b3073f78/raw/24a7e1453e65a26a8aa12cd0fb266ed9679816aa/people.json");
    return data;
}

const getPersonById = async function getPersonById(id){
    if(id === undefined || id === null || typeof id != "number"){
        throw "Error: please ensure the argument is a number for function getPersonById";
    }
    
    let matching = [];

    let people = await getPeople();

    if(id > people.length || id < 1){
        throw "Error: provided id is not within the bounds of the list of people";
    }
    people.forEach(person => {
        if(person["id"] == id){
            matching.push(person);
        }
    });
    return matching;

}

const getPersonByFirstName = async function getPersonByFirstName(name){
    if(typeof name !== "string"){
        throw new Error("Name provided must be of type string");
    }
    let people = await getPeople();
    let matching = [];
    people.forEach(person =>{
        if(person["firstName"] == name){
            matching.push(person);
        }
    });
    return matching;
}

const getPersonByLastName = async function getPersonByLastName(name){
    if(typeof name !== "string"){
        throw new Error("Name provided must be of type string");
    }
    let people = await getPeople();
    let matching = [];

    people.forEach(person =>{
        if(person["lastName"] == name){
            matching.push(person);
        }
    });
    return matching;
}

const getPersonByFullName = async function getPersonByFullName(fName,lName){
    if(typeof fName !== "string"){
        throw new Error("Name provided must be of type string");
    }
    if(typeof lName !== "string"){
        throw new Error("Name provided must be of type string");
    }
    let people = await getPeople();
    let matching = [];

    people.forEach(person =>{
        if(person["firstName"] == fName && person["lastName"] == lName){
            matching.push(person);
        }
    });
    return matching;
}




module.exports = {
    getPersonById,
    getPersonByFirstName,
    getPersonByLastName,
    getPersonByFullName
};