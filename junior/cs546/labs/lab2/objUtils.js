/*
*   Christopher Rudel
*   CS546
*   objUtils.js
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const extend = function extend(...theArgs){
    if(theArgs.length < 2){
        throw "Error: please ensure there is at least 2 arguments for function extend";
    } else{
        for(let i=0; i<theArgs.length; i++){
            if(theArgs[i].constructor !== Object){
                throw "Error: please ensure all arguments are of type Object for function extend";
            }else if(Object.entries(theArgs[i]).length === 0 || theArgs[i] === undefined){
                throw "Error: please ensure all objects are non empty for function extend";
            }
        }
    }
    let retMe = {};
    let keys = new Array(theArgs.length);
    let keyArr = [];
    let valueArr = [];
    for(let i=0; i<theArgs.length; i++){
        keyArr = keyArr.concat(Object.keys(theArgs[i])); // this takes all the keys and puts them into an array
        valueArr = valueArr.concat(Object.values(theArgs[i])); // this takes all the values and puts them into an array
    }

    for(let i=0; i<keyArr.length; i++){
        if(keyArr[i] in retMe){
            continue;
        }else{
            retMe[keyArr[i]] = valueArr[i];
        }
    }

    return retMe;
}

const smush = function smush(...theArgs){
    if(theArgs.length < 2){
        throw "Error: please ensure there is at least 2 arguments for function smush";
    } else{
        for(let i=0; i<theArgs.length; i++){
            if(theArgs[i].constructor !== Object){
                throw "Error: please ensure all arguments are of type Object for function smush";
            }else if(Object.entries(theArgs[i]).length === 0 || theArgs[i] === undefined){
                throw "Error: please ensure all objects are non empty for function smush";
            }
        }
    }
    let retMe = {};
    for(let i=0; i<theArgs.length; i++){
        retMe = {...retMe, ...theArgs[i]};
    }

    return retMe;
}

const mapValues = function mapValues(obj, func){
    if(typeof obj !== "object"){
        throw "Error: please ensure the first argument is of type Object for function mapValues";
    } else if(Object.entries(obj).length === 0 || obj === undefined){
        throw "Error: please ensure the object provided is non empty for function mapValues";
    } else if(typeof func !== "function" || func === undefined){
        throw "Error: please ensure the second argument is of type Function for function mapValues";
    }
    
    let retMe = {};
    for(let objKey in obj){
        retMe[objKey] = func(obj[objKey]);
    }
    return retMe;

    // there was probably a way to do something this elegant for the function extend
    // but what i did works so no point in going back to try and make it elegant
    // i might break it
}

module.exports = {
	firstName: "Christopher",
    lastName: "Rudel",
    studentId: "10413032",
    extend,
    smush,
    mapValues
};