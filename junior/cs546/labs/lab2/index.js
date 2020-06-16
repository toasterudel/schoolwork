/*
*   Christopher Rudel
*   CS546
*   index.js
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const arrayUtils = require("./arrayUtils");
const stringUtils = require("./stringUtils");
const objUtils = require("./objUtils");

// Head tests
try{
    // should pass
    const headOne = arrayUtils.head([true,'1',2,3]);
    console.log("Head passed successfully")
}catch (e){
    console.error("Head test case failed")
}
try{
    // should fail
    const headTwo = arrayUtils.head(arguments[0]);
    console.error("Head did not error");
}catch(e){
    console.log("Head failed successfully");
}

// remove tests
try{
    // should pass
    const removeOne = arrayUtils.remove([null, 0, '0', undefined, false], 3);
    console.log("Remove passed successfully");
}catch(e){
    console.error("Remove test case failed");
}
try{
    //should fail
    const removeTwo = arrayUtils.remove([1,2,3,4], 4); // 4 is the length of the array, bigger than an index
    console.error("Remove did not error");
}catch(e){
    console.log("Remove failed successfully ")
}

// countChars test
try{
    // should pass
    const countOne = stringUtils.countChars('I love web programming');
    console.log("countChars passed successfully");
}catch(e){
    console.error("countChars test case failed");
}
try{
    // should fail
    const countTwo = stringUtils.countChars(false);
    console.error("countChars did not error");
}catch(e){
    console.log("countChars failed successfully");
}

// extend test
try{
    // should pass
    const extendOne = objUtils.extend({ a: 70, x: 4, z: 5 }, { x: 0, y: 9, q: 10 });
    console.log("Extend passed successfully");
}catch(e){
    console.error("Extend test case failed");
}
try{
    // should fail
    const extendTwo = objUtils.extend({ a: 70, x: 4, z: 5}, [1,2,3,4]);
    console.error("Extend did not error");
}catch(e){
    console.log("Extend failed successfully");
}
