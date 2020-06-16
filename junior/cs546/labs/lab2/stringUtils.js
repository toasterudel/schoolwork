/*
*   Christopher Rudel
*   CS546
*   stringUtils.js
*   I pledge my honor that I have abided by the Stevens Honor System
*/
const capitalize = function capitalize(str) {
    if(str === undefined || str === null || typeof str != "string"){
      throw "Error: please input a string for function capitalize";
    }
    else{
      if(str == ""){
        return "";
      }
      let lowerStr = str.toLowerCase();
      let retMe = str.charAt(0).toUpperCase() + lowerStr.substr(1);
      return retMe;
    }
}

const repeat = function repeat(str, num) {
  if(str === undefined || str === null || typeof str != "string"){
    throw "Error: please input a string for function repeat";
  }
  else if(num === undefined || num === null || !Number.isInteger(num)){
    throw "Error: please input a valid number for function repeat";
  }
  else if(num < 0){
    throw "Error: ensure the provided number is > 0 for function repeat";
  }
  else{
    let retMe = "";
    for(let i=0; i<num; i++){
      retMe += str;
    }
    return retMe;
  }
}

const countChars = function countChars(str) {
  if(str === undefined || str === null || typeof str != "string"){
    throw "Error: please input a string for function countChars";
  }
  // the assignment said we can use a past function to help 
  const arrayUtils = require("./arrayUtils");
  let strArray = new Array(str.length);
  for(let i=0; i<str.length; i++){
    strArray[i] = str.charAt(i);
  }
  let retMe = arrayUtils.countElements(strArray);
  return retMe;

}

module.exports = {
    firstName: "Christopher",
    lastName: "Rudel",
    studentId: "10413032",
		capitalize,
		repeat,
		countChars
};
