/*
*   Christopher Rudel
*   CS546
*   arrayUtils.js
*   I pledge my honor that I have abided by the Stevens Honor System
*/
const head = function head(arr) {
	if(arr === undefined || arr.constructor !== Array){
		throw "Error: please ensure to input a variable of type array for function head";
	}
	else if(arr.length == 0){
		throw "Error: please input a non empty array for function head";
	}
	else{
		return arr[0];
	}
}

const last = function last(arr) {
	if(arr === undefined || arr.constructor !== Array){
		throw "Error: please ensure to input a variable of type array for function last";
	}
	else if(arr.length == 0){
		throw "Error: please input a non empty array for function last";
	}
	else{
		return arr[arr.length-1];
	}
}

const remove = function remove(arr, index) {
	if(arr === undefined || arr.constructor !== Array){
		throw "Error: please ensure to input a variable of type array for function remove";
	}
	else if(arr.length == 0){
		throw "Error: please input a non empty array for function remove";
	}
	else if(index >= arr.length || index < 0){
		throw "Error: please ensure the index is within the bounds of the array for function remove";
	}
	else if(isNaN(index) || index === null || index === undefined){
		throw "Error: please input a number for the index for function remove";
	}
	else{
		arr.splice(index,1);
		return arr;
	}
}

const range = function range(end, value) {
	if(!Number.isInteger(end)){ // integers will get past this and so will doubles like 1.0
		throw "Error: please ensure the length is a valid integer > 0 for function range";
	}
	else{
		if(end <= 0){
			throw "Error: please enter a number greater than 0 for function range";
		}
		let retMe = new Array(end);
		if(value === undefined || value === null){
			for(let i = 0; i < retMe.length; i++){
				retMe[i] = i;
			}
			
		} else{
			retMe.fill(value);
		}
		return retMe;
	}
}

const countElements = function countElements(arr) {
	if(arr === undefined || arr.constructor !== Array){
		throw "Error: please ensure to input a variable of type array for function countElements";
	}	// if the array is empty we can still count it, it'll just be 0
	let count = {};
	arr.forEach(element => count[element] = (count[element] || 0) + 1);
	return count;
}

const isEqual = function isEqual(arr1, arr2) {
	if(arr1 === undefined || arr1.constructor !== Array || arr2 === undefined || arr2.constructor !== Array){
		throw "Error: please ensure to input a variable of type array for function isEqual";
	}
	else {
		if(arr1.length != arr2.length){
			return false;
		}
		let retMe = true;
		for(let i=0; i<arr1.length; i++){
			if(arr1[i] != arr2[i]){
				retMe = false;
			}
		}
		return retMe;
	}
}

module.exports = {
	firstName: "Christopher",
    lastName: "Rudel",
    studentId: "10413032",
    head,
	last,
	remove,
	range,
	countElements,
	isEqual
};
