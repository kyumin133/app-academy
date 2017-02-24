const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft <= 0) {
    completionCallback(sum);
  } else {
    reader.question("Enter number: ", function(answer) {
      let parsed = parseInt(answer);
      sum += parsed;
      console.log(`Partial sum: ${sum}`);
      addNumbers(sum, numsLeft - 1, completionCallback);
    });
  }
}

addNumbers(0, 3, sum => {
  console.log(`Total Sum: ${sum}`);
  reader.close();
});
