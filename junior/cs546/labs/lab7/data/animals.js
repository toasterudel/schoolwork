/*
*   Christopher Rudel
*   CS546
*   posts.js
*   lab7
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const mongoCollections = require("../config/collections");
const animals = mongoCollections.animals;
const uuid = require("node-uuid");

const create = async function create(name, animalType){
    if(name === null || name === undefined || animalType === null || animalType === undefined){
        throw new Error("Ensure arguments exist; cannot be null or undefined");
    }
    if(typeof name != "string") throw new Error("Name needs to be of type string");
    if(typeof animalType != "string") throw new Error("animalType needs to be of type string");
    let animalCollection = await animals();

    let newAnimal = {
        _id: uuid.v4(),
        name: name,
        animalType: animalType,
        likes: [],
        posts: []
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
    /*console.log(id);
    if(typeof id == "string"){
        try{
            ObjectId = require('mongodb').ObjectID;
            id = ObjectId(id);
        }catch(e){throw new Error(`Provided id: ${id} is not a valid mongo id`);}
    }*/
    
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
    /*
    if(typeof id == "string"){
        try{
            ObjectId = require('mongodb').ObjectID;
            id = ObjectId(id);
        }catch(e){throw new Error(`Provided id: ${id} is not a valid mongo id`);}
    }*/
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

const rename = async function rename(id, updatedAnimal){
    if(id === null || id === undefined || updatedAnimal === null || updatedAnimal === undefined){
        throw new Error("Ensure arguments exist; cannot be null or undefined");
    }
    if(!(typeof id == "string" || typeof id == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    if(typeof updatedAnimal != "object") throw new Error("The new name argument needs to be an object");
    let animalCollection = await animals();
    let oldAnimal = await this.get(id);
    let newAnimal = {};
    if(updatedAnimal.newName){
        newAnimal.name = updatedAnimal.newName;
    }
    if(updatedAnimal.newType){
        newAnimal.animalType = updatedAnimal.newType;
    }
    let updateCommand = {
        $set: newAnimal
    };
    
    const updatedInfo = await animalCollection.updateOne({_id: oldAnimal._id}, updateCommand);
    /*
    if(updatedInfo.modifiedCount === 0){
        throw new Error(`Could not update animal: ${id} successfully`);
    }*/

    return await this.get(id);
}

const addPost = async function addPost(id, post){
    if(!(typeof id == "string" || typeof id == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    if(typeof post !== "object"){
        throw new Error("The desired post is not of type object");
    }
    let animalCollection = await animals();
    let postToAdd = {
        "_id": post._id,
        "title": post.title
    };
    const updatedInfo = await animalCollection.updateOne({_id: id}, {$push: {posts: postToAdd}});
    if(updatedInfo.modifiedCount === 0){
        throw new Error(`Could not add post: ${id} successfully`);
    }
    return await this.get(id);
}

const deletePost = async function deletePost(animalId, postId){
    if(!(typeof animalId == "string" || typeof animalId == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    if(!(typeof postId == "string" || typeof postId == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    let animalCollection = await animals();
    let animalPoster = await this.get(animalId);

    let newPosts = animalPoster.posts;
    for(let i=0; i<newPosts.length; i++){
        if(newPosts[i]._id == postId){
            newPosts.splice(i,1);
            break;
        }
    }
    const updatedInfo = await animalCollection.updateOne({_id: animalId}, {$set: {posts: newPosts}});
    if(updatedInfo.modifiedCount === 0){
        throw new Error(`Could not remove post: ${postId} successfully`);
    }
    return await this.get(animalId);
}

const updatePost = async function updatePost(animalId, postId, newTitle){
    if(!(typeof animalId == "string" || typeof animalId == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    if(!(typeof postId == "string" || typeof postId == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    if(typeof newTitle !== "string"){
        throw new Error("New title needs to be a string");
    }
    let animalCollection = await animals();
    let animalPoster = await this.get(animalId);

    let updatedPost = {
        "_id": postId,
        "title": newTitle
    };
    let newPosts = animalPoster.posts;
    for(let i=0; i<newPosts.length; i++){
        if(newPosts[i]._id == postId){
            newPosts[i] = updatedPost;
            break;
        }
    }
    //console.log("made it");
    const updatedInfo = await animalCollection.updateOne({_id: animalId}, {$set: {posts: newPosts}});
    //console.log("here");
    /*
    if(updatedInfo.modifiedCount === 0){
        throw new Error(`Could not update post: ${postId} successfully`);
    }*/
    return await this.get(animalId);

}




module.exports = {
    firstName: "Christopher",
    lastName: "Rudel",
    studentId: "10413032",
    create,
    getAll,
    get,
    remove,
    rename,
    addPost,
    deletePost,
    updatePost
};