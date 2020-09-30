main(20);

function main(input) {
    console.log(findPrimeNumbers(input));
}

function findPrimeNumbers(limit) {
    let primeNumbers = [];
            
    for (let number = 2; number < limit; number++) 
        if (isPrime(number))
            primeNumbers.push(number);

    return primeNumbers;
}

function isPrime(number) {
    for (let factor = 2; factor < number; factor++) 
        if (number % factor === 0) 
            return false;
    
    return true;
}