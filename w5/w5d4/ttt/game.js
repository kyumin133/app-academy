const Board = require("./board.js");

class Game {
  constructor() {
    this.board = new Board();
    this.current_mark = "X";
  }

  promptMove(reader, completionCallback) {
    const game = this;
    game.board.print();
    console.log(`${game.current_mark}'s move.`)
    reader.question("Row: ", function(row) {
      reader.question("Column: ", function(col) {
        let pos = [row, col];
        if (game.board.placeMark(pos, game.current_mark)) {
          if (game.board.isWon()) {
            console.log(`${game.board.winner()} wins!`)
            completionCallback();
          } else {
            game.switchMark();
            game.promptMove(reader, completionCallback)
          }
        } else {
          console.log("Invalid move.");
          game.promptMove(reader, completionCallback);
        }
      });
    });
  }

  switchMark() {
    if (this.current_mark === "X") {
      this.current_mark = "O";
    } else {
      this.current_mark = "X";
    }
  }

  run(reader, completionCallback) {
    this.promptMove(reader, completionCallback);
  }
}
module.exports = Game;
