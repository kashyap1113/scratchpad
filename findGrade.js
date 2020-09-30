function main() {
    const marks = [80, 80, 50];
    
    let average = calculateAverage(marks);
    let grade = calculateGrade(average);
    console.log(grade);
}

function calculateAverage(array) {
    let sum = 0;
    for (number of array) {
        sum += number;
    }
    return sum / array.length;
}

function calculateGrade(average) {
    if (average < 60) return 'F';
    if (average < 70) return 'D';
    if (average < 80) return 'C';
    if (average < 90) return 'B';
    return 'A';
}

console.log(main());