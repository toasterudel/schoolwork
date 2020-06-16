/*
*   Christopher Rudel
*   CS546
*   index.js
*   lab4
*   I pledge my honor that I have abided by the Stevens Honor System
*/
const connection = require("./data/connection");
const animals = require("./data/animals");

const start = async function start(){

    let sasha = await animals.create("Sasha", "Dog");
    console.log(sasha);         // [Sasha]
    let lucy = await animals.create("Lucy", "Dog");
    let allAnimals = await animals.getAll();
    console.log(allAnimals);    // [Sasha, Lucy]
    let duke = await animals.create("Duke", "Walrus");
    console.log(duke);          // [Sasha, Lucy, Duke]
    let sashita = await animals.rename(sasha._id, "Sashita");
    console.log(sashita);       // [Sashita, Lucy, Duke]
    let byeLucy = await animals.remove(lucy._id);
    allAnimals = await animals.getAll();    
    console.log(allAnimals);    // [Sashita, Duke]

    //Closing connection to db
    const db = await connection();
    await db.serverConfig.close();
    //console.log("\nDone");
}

start();