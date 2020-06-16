/*
*   Christopher Rudel
*   CS546
*   animals.js
*   lab4
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const mongoCollections = require("./collections");
const animals = mongoCollections.animals;

const create = async function create(name, animalType){
    if(name === null || name === undefined || animalType === null || animalType === undefined){
        throw new Error("Ensure arguments exist; cannot be null or undefined");
    }
    if(typeof name != "string") throw new Error("Name needs to be of type string");
    if(typeof animalType != "string") throw new Error("animalType needs to be of type string");
    let animalCollection = await animals();

    let newAnimal = {
        name: name,
        animalType: animalType
    };

    let insertInfo = await animalCollection.insertOne(newAnimal);
    if(insertInfo.insertedCount === 0) throw new Error("Could not insert animal");

    let newId = insertInfo.insertedId;
    //console.log(typeof newId);
    let animal = await this.get(newId);
    return animal;


}

const getAll = async function getAll(){
    let animalCollection = await animals();
    let allAnimals = await animalCollection.find({}).toArray();
    return allAnimals;
}

const get = async function get(id){
    if(id === null || id === undefined){
        throw new Error("Ensure id argument exists; cannot be null or undefined");
    }
    if(!(typeof id == "string" || typeof id == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    if(typeof id == "string"){
        try{
            ObjectId = require('mongodb').ObjectID;
            id = ObjectId(id);
        }catch(e){throw new Error(`Provided id: ${id} is not a valid mongo id`);}
    }
    
    let animalCollection = await animals();
    let findAnimal = await animalCollection.findOne({ _id: id });
    if(findAnimal === null) throw new Error(`No animal with id: ${id}`);
    return findAnimal;
}

const remove = async function remove(id){
    if(id === null || id === undefined){
        throw new Error("Ensure id argument exists; cannot be null or undefined");
    }
    if(!(typeof id == "string" || typeof id == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    if(typeof id == "string"){
        try{
            ObjectId = require('mongodb').ObjectID;
            id = ObjectId(id);
        }catch(e){throw new Error(`Provided id: ${id} is not a valid mongo id`);}
    }
    let animalCollection = await animals();
    let animalToRemove = await this.get(id);
    let deletedAnimal = {
        deleted: true,
        data: animalToRemove
    };

    let deletionInfo = await animalCollection.removeOne({_id: id});
    if(deletionInfo.deletedCount === 0) throw new Error(`Could not delete animal with id: ${id}`);

    return deletedAnimal;
}

const rename = async function rename(id, newName){
    if(id === null || id === undefined || newName === null || newName === undefined){
        throw new Error("Ensure arguments exist; cannot be null or undefined");
    }
    if(!(typeof id == "string" || typeof id == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    if(typeof newName != "string") throw new Error("The new name argument needs to be a string");
    let animalCollection = await animals();
    let oldAnimal = await this.get(id);
    if(oldAnimal.name == newName){return oldAnimal;} // if the names are equal an error occurs
    let newAnimal = {
        $set:{
            name: newName,
            animalType: oldAnimal.animalType
        }
    };

    const updatedInfo = await animalCollection.updateOne({_id: oldAnimal._id}, newAnimal);
    if(updatedInfo.modifiedCount === 0){
        throw new Error(`Could not update animal: ${id} successfully`);
    }

    return await this.get(id);
}



module.exports = {
    firstName: "Christopher",
    lastName: "Rudel",
    studentId: "10413032",
    create,
    getAll,
    get,
    remove,
    rename
};