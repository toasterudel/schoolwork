const express = require('express');
const router = express.Router();
const data = require('../data');
const prime = data.prime;

router.get('/', (req,res) =>{
    res.render('prime/static');
});

router.post('/', (req, res) =>{
    let testVal = req.body.prime;
    try{
        if(prime.isPrime(testVal)){
            let isPrime = true;
            console.log("true");
        }else{
            let isPrime = false;
            console.log("false");
        }
    }catch(e){
        console.log("error");
        res.render('prime/server', {isPrime: false, error: e});
        return;
    }
    res.render('prime/server', {isPrime: isPrime});
});

module.exports = router;