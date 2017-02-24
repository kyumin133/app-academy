class Game {
  constructor() {
    this.stacks = [[3, 2, 1], [], []];
  }
  promptMove(reader, completionCallback) {
    const game = this;
    this.print();
    reader.question("Starting tower: ", function(startTowerIdx) {
      reader.question("Ending tower: ", function(endTowerIdx) {
        let move_bool = game.move(startTowerIdx, endTowerIdx);
        if (!move_bool) {
          game.promptMove(reader, completionCallback);
        } else {
          if (game.isWon()) {
            game.print();
            console.log("You win!");
            completionCallback();
          } else {
            game.promptMove(reader, completionCallback);
          }
        }
      });
    });
  }

  print() {
    console.log("")
    for (let i = 0; i < 3; i++) {
      this.printStack(this.stacks[i], i);
    }
  }

  printStack(stack, num) {
    let str = `${num}: `;
    for (let i = 0; i < stack.length; i++) {
      str = str.concat(`${stack[i]} `);
    }
    console.log(str)
  }

  isValidMove(startTowerIdx, endTowerIdx) {
    if ((startTowerIdx < 0) || (startTowerIdx > 2) || (endTowerIdx < 0) || (endTowerIdx > 2)) {
      return false;
    }
    if ((this.stacks[startTowerIdx].length === 0) || (startTowerIdx === endTowerIdx)) {
      return false;
    }
    if (this.stacks[endTowerIdx].length === 0) {
      return true;
    }

    let start_stack = this.stacks[startTowerIdx]
    let end_stack = this.stacks[endTowerIdx]
    let start_piece = start_stack[start_stack.length - 1];
    let end_piece = end_stack[end_stack.length - 1];
    return (start_piece < end_piece);
  }

  move(startTowerIdx, endTowerIdx) {
    const game = this;
    if (game.isValidMove(startTowerIdx, endTowerIdx)) {
      let start_piece = game.stacks[startTowerIdx].pop();
      game.stacks[endTowerIdx].push(start_piece);
      return true;
    } else {
      console.log("Invalid move");
      return false;
    }
  }

  isWon() {
    if (this.stacks[0].length > 0) {
      return false;
    }
    if ((this.stacks[1].length === 0) || (this.stacks[2].length === 0)) {
      return true;
    }
    return false;
  }

  run(reader, completionCallback) {
    this.promptMove(reader, completionCallback);
  }
}

module.exports = Game;
