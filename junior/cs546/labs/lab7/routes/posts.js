/*
*   Christopher Rudel
*   CS546
*   posts.js
*   lab7
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const express = require("express");
const router = express.Router();
const data = require("../data");
const postData = data.posts;
const animalData = data.animals;

router.get("/", async(req, res) =>{
    try{
        const postList = await postData.getAll();
        res.status(200).send(postList);
    }catch(e){
        res.status(500).json({error: e});
    }
});

router.get("/:id", async (req,res) => {
    try{
        const post = await postData.getPostById(req.params.id);
        res.status(200).send(post);
    }catch(e){
        res.json({error: "Post not found"});
    }
});

router.post("/", async (req, res) => {
    const blogPostData = req.body;
    try{
        const {title, author, content} = blogPostData;
        const newPost = await postData.addPost(title, content, author);
        await animalData.addPost(author, newPost); //necessary to automatically update the posts in animals
        
        res.status(200).send(newPost);
    }catch(e){
        res.status(500).json({error: e});
    }
});

router.put("/:id", async (req,res) => {
    const updatedData = req.body;
    let postToUpdate;
    try{
        postToUpdate = await postData.getPostById(req.params.id);
    }catch(e){
        res.status(404).json({error: "Post not found"});
    }

    try{
        const {title, content, author} = postToUpdate;
        const{id, name} = author;
        const updatedPost = await postData.updatePost(req.params.id, updatedData);
        //console.log("here");
        await animalData.updatePost(id, req.params.id, updatedData.newTitle); //necessary to automatically update the post in animals
        //console.log("too");
        res.status(200).send(updatedPost);
    }catch(e){
        res.status(500).json({error: e});
    }
});

router.delete("/:id", async (req, res) => {
    let postToDelete;
    try{
        postToDelete = await postData.getPostById(req.params.id);
    }catch(e){
        res.status(404).json({error: "Post not found"});
    }

    try{
        const {title, content, author} = postToDelete;
        const {id, name} = author;
        const deletedPost = await postData.removePost(req.params.id);
        await animalData.deletePost(id,req.params.id); //necessary to automatically delete the post in animals
        res.status(200).send(deletedPost);
    }catch(e){
        res.status(500).json({error: e});
    }
});

module.exports = router;