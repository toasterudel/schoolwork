/*
*   Christopher Rudel
*   CS546
*   posts.js
*   lab7
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const mongoCollections = require("../config/collections");
const posts = mongoCollections.posts;
const animals = require("./animals");
const uuid = require("node-uuid");

const getAll = async function getAll(){
    let postCollection = await posts();
    let allPosts = await postCollection.find({}).toArray();
    return allPosts;
}

const getPostById = async function getPostById(id){
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
    const postCollection = await posts();
    const post = await postCollection.findOne({ _id: id});

    if(!post) throw new Error(`Post: ${id} not found`);
    return post;
}


const addPost = async function addPost(title, content, authorId){
    if(typeof title !== "string") throw new Error("No title provided");
    if(typeof content !== "string") throw new Error("No body provided");
    if(!(typeof authorId == "string" || typeof authorId == "object")){
        throw new Error("Invalid type of the author ID");
    }
    const postCollection = await posts();
    const animalPoster = await animals.get(authorId);

    const newPost = {
        _id: uuid.v4(),
        title: title,
        content: content,
        author:{
            id: authorId,
            name: animalPoster.name
        }
    };

    const newInsertInfo = await postCollection.insertOne(newPost);
    const newId = newInsertInfo.insertedId;
    return await this.getPostById(newId);
}

const removePost = async function removePost(id){
    if(!(typeof id === "string" || typeof id === "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    /*
    if(typeof id === "string"){
        try{
            ObjectId = require('mongodb').ObjectID;
            id = ObjectId(id);
        }catch(e){throw new Error(`Provided id: ${id} is not a valid mongo id`);}
    }*/
    const postCollection = await posts();
    
    let deletedPost = await this.getPostById(id);
    
    let deletedIdInfo = {
        deleted: true,
        data: deletedPost
    };
    const deletionInfo = await postCollection.removeOne({_id: id});
    if(deletionInfo.deletedCound === 0){
        throw new Error(`Could not delete post with id: ${id}`);
    }

    return deletedIdInfo;

}

const updatePost = async function updatePost(id, updatedPost){
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
    if(!(typeof updatedPost == "object")){
        throw new Error("New post needs to be an object");
    }
    
    const postCollection = await posts();
    
    let updatedPostData = {};
    
    if(updatedPost.newTitle){
        updatedPostData.title = updatedPost.newTitle;
    }
    if(updatedPost.newContent){
        updatedPostData.content = updatedPost.newContent;
    }
    

    let updateCommand = {
        $set: updatedPostData
    };
    let query = {
        _id: id
    };

    
    await postCollection.updateOne(query, updateCommand);
    
    return await this.getPostById(id);
}

const removeAnimalsPosts = async function removeAnimalsPosts(animalId){
    if(!(typeof animalId == "string" || typeof animalId == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    let postArr = await this.getAll();
    let postsToRemove = [];
    for(let i=0; i<postArr.length; i++){
        if(postArr[i].author.id == animalId){
            postsToRemove.push(postArr[i]._id);            
        }
    }
    //console.log(postsToRemove);
    for(let i=0; i<postsToRemove.length; i++){
        await this.removePost(postsToRemove[i]);
    }
    return;
}

const animalNameUpdate = async function animalNameUpdate(animalId, newName){
    if(!(typeof animalId == "string" || typeof animalId == "object")){
        throw new Error("Id needs to be a string or ObjectId");
    }
    if(typeof newName !== "string"){
        throw new Error("The new name needs to be a string");
    }
    const postCollection = await posts();
    let postArr = await this.getAll();
    let postsToModify = [];
    for(let i=0; i<postArr.length; i++){
        if(postArr[i].author.id == animalId){
            postsToModify.push(postArr[i]._id);            
        }
    }
    for(let i=0; i<postsToModify.length; i++){
        let updatedInfo = {
            author: {
                id: animalId,
                name: newName
            }
        };
        let updateCommand = {
            $set: updatedInfo
        };
        let query = {
            _id: postsToModify[i]
        };
        await postCollection.updateOne(query, updateCommand);
    }
}

module.exports = {
    firstName: "Christopher",
    lastName: "Rudel",
    studentId: "10413032",
    getAll,
    getPostById,
    addPost,
    removePost,
    updatePost,
    removeAnimalsPosts,
    animalNameUpdate
};