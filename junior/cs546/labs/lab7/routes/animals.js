/*
*   Christopher Rudel
*   CS546
*   animals.js
*   lab7
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const express = require("express");
const router = express.Router();
const data = require("../data");
const animalData = data.animals;
const postData = data.posts;

router.get("/:id", async(req, res) => {
    try{
        const animal = await animalData.get(req.params.id);
        res.status(200).send(animals);
    }catch(e){
        res.status(404).json({error: "Animal not found",
    realerror: e});
    }
});

router.get("/", async(req, res)=>{
    try{
        const animalList = await animalData.getAll();
        res.status(200).send(animalList);
    }catch(e){
        res.sendStatus(500);
    }
});

router.post("/", async (req, res) => {
    const animalInfo = req.body;

    if(!animalInfo) {
        res.status(400).json({error: "You must provide data to create a animal"});
        return;
    }
    if(!animalInfo.name){
        res.status(400).json({error: "You must provide a name"});
    }
    if(!animalInfo.animalType){
        res.status(400).json({error: "You must provide an animal type"});
    }

    try{
        const newAnimal = await animalData.create(
            animalInfo.name,
            animalInfo.animalType
        );
        res.status(200).send(newAnimal);
    }catch(e){
        res.sendStatus(500);
    }
});

router.put("/:id", async (req, res) => {
    const animalInfo = req.body;

    if(!animalInfo) {
        res.status(400).json({error: "You must provide data to create a animal"});
        return;
    }
    if(!(animalInfo.newName) && !(animalInfo.newType)){
        res.status(400).json({error: "Please provide either newName or newType"});
    }
    try{
        await animalData.get(req.params.id);
    }catch(e){
        //console.log(e);
        res.status(404).json({error: "Animal not found"});
    }
    try{
        const updatedAnimal = await animalData.rename(req.params.id, animalInfo);
        if(animalInfo.newName){     // if the animal only updated their type it doesnt affect the posts database
            await postData.animalNameUpdate(req.params.id, animalInfo.newName);
        }
        res.status(200).send(updatedAnimal);

    }catch(e){
        //console.log(e);
        res.sendStatus(500).json({error: e});
    }
});

router.delete("/:id", async (req,res) =>{
    try{
        await animalData.get(req.params.id);
    }catch(e){
        res.status(404).json({error: "Post not found"});
    }
    try{
        const deletedAnimal = await animalData.remove(req.params.id);
        await postData.removeAnimalsPosts(req.params.id);
        res.status(200).send(deletedAnimal);
    }catch(e){
        //console.log(e);
        res.status(500).json({error: e});
    }
});

module.exports = router;