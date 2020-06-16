/*
*   Christopher Rudel
*   CS546
*   lab1.js
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const questionOne = function questionOne(arr) {
    //sum of squares
    let sum = 0;
    for(let i=0; i<arr.length; i++)
    {
        if(Number.isInteger(arr[i]) == false){
            throw "Error: please make sure all values are integers";
        }else{
            sum += arr[i] * arr[i];
        }
    }
    return sum;
}

const questionTwo = function questionTwo(num) { 
    //fibonacci 
    if(Number.isInteger(num) == false){
        throw "Error: please input an integer";
    }
    if(num <= 0)
        return 0;
    else if(num == 1)
        return 1;
    else{
        return questionTwo(num-1) + questionTwo(num-2);
    }
}

const questionThree = function questionThree(text) {
    //counting vowels not including y
    if(typeof text != "string" && typeof text!= "character"){
        throw "Error, please enter a string or character";
    }
    let count = 0;
    let lowerText = text.toLowerCase();
    for(let i=0; i<lowerText.length; i++)
    {
        if(lowerText.charAt(i) == 'a' || lowerText.charAt(i) == 'e' || lowerText.charAt(i) == 'i' || lowerText.charAt(i) == 'o' || lowerText.charAt(i) == 'u')
            count++;
        //I may have been able to do lowerText[i] instead of charAt but this works anyways
    }
    return count;
}

const questionFour = function questionFour(num) {
    //factorial
    if(Number.isInteger(num) == false){
        throw "Error: please input an integer";
    }   /*I think there is a way to compute the factorial of a non-integer number but
          I think that would be way above the expected complexity of the function */
    if(num < 0)
        return NaN;
    else if(num == 0 || num == 1)
        return 1;
    else
        return num * questionFour(num-1);
}

module.exports = {
    firstName: "Christopher", 
    lastName: "Rudel", 
    studentId: "10413032",
    questionOne,
    questionTwo,
    questionThree,
    questionFour
};
