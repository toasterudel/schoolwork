const isPrime = function isPrime(num){
    if(typeof num !== 'number'){
        throw new Error('Please input a number');
    }
    if(isNaN(num)){
        throw new Error('Not a number');
    }
    if(num <= 1){
        return false;
    }
    if(num == 2){
        return true;
    }

    let prime = true;
    for(let i=2; i<num; i++){
        if(num % i == 0){
            prime = false;
            break;
        }
    }

    return prime;
}

module.exports = isPrime;