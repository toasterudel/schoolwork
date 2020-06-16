/*
*   Christopher Rudel
*   CS546
*   lab1.test.js
*   I pledge my honor that I have abided by the Stevens Honor System
*/

const lab1 = require("./lab1");

// Note: the Assignment told me to log Question One 5 times so I did that.
// The assignment didn't say anything about logging the other functions multiple
// times so I didn't, but I did put them through testing similarly to the first question. 

console.log("Question One:")
console.log(lab1.questionOne([1, 2, 3])); 
// should output 14
console.log(lab1.questionOne([6, 4, 0]));
// should output 52
console.log(lab1.questionOne([10, 20, 30]));
// should output 1400
console.log(lab1.questionOne([0, 0, 0]));
// should output 0
console.log(lab1.questionOne([-4, 20, 9]) + "\n");
// should output 497

console.log("Question Two:")
console.log(lab1.questionTwo(7) + "\n"); 
// should output 13 

console.log("Question Three:");
console.log(lab1.questionThree("Mr. and Mrs. Dursley, of number four, Privet Drive, were  proud  to  say  that  they  were  perfectly  normal,  thank you  very  much. They  were  the  last  people  youd  expect  to  be  involved in anything strange or mysterious, because they just didn't hold with such nonsense. \n Mr. Dursley was the director of a firm called Grunnings, which  made  drills.  He  was  a  big,  beefy  man  with  hardly  any  neck,  although he did have a very large mustache. Mrs. Dursley was thin and blonde and had nearly twice the usual amount of neck, which came in very useful as she spent so much of her time craning over garden fences, spying on the neighbors. The Dursleys had a small son  called  Dudley  and  in  their  opinion  there  was no finer boy anywhere.") + '\n'); 
// should output 196

console.log("Question Four:")
console.log(lab1.questionFour(10)); 
// should output 3628800
