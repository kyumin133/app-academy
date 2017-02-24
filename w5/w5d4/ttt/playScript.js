const Game = require("./game.js");
const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});



let g = new Game();
g.run(reader, playAgain);

function playAgain() {
  reader.question("Play again (y/n)? ", function(again) {
    if (again == "y") {
      g = new Game();
      g.run(reader, playAgain);
    } else {
      reader.close();
    }
  });
}
