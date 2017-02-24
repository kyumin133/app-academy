class Board {
  constructor () {
    this.grid = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
  }

  print() {
    console.log("-------------");
    for (let i = 0; i < 3; i++) {
      let print_str = "|"
      for (let j = 0; j < 3; j++) {
        print_str = print_str.concat(this.toString(this.grid[i][j]));
      }
      console.log(print_str);
      console.log("-------------");
    }
  }

  toString(i) {
    if (i === 0) {
      return "   |"
    } else if (i === -1) {
      return " O |"
    } else {
      return " X |"
    }
  }

  isWon() {
    return (this.winner() !== null);
  }

  winner() {
    let down_diag_sum = 0;
    let up_diag_sum = 0;
    for (let i = 0; i < 3; i++) {
      down_diag_sum += this.grid[i][i];
      up_diag_sum += this.grid[2 - i][i];

      let row_sum = 0;
      let col_sum = 0;
      for (let j = 0; j < 3; j++) {
        row_sum += this.grid[i][j];
        col_sum += this.grid[j][i];
      }

      if ((row_sum === 3) || (col_sum === 3)) {
        return "X";
      }
      if ((row_sum === -3) || (col_sum === -3)) {
        return "O";
      }
    }

    if ((up_diag_sum === 3) || (down_diag_sum === 3)) {
      return "X";
    }
    if ((up_diag_sum === -3) || (down_diag_sum === -3)) {
      return "O";
    }
    return null;
  }

  isEmpty(pos) {
    return (this.grid[pos[0]][pos[1]] === 0);
  }

  isOnBoard(pos) {
    if ((pos[0] < 0) || (pos[0] > 2) || (pos[1] < 0) || (pos[1] > 2)) {
      return false;
    }
    return true;
  }

  placeMark(pos, mark) {
    if (!this.isEmpty(pos) || !this.isOnBoard(pos)) {
      return false;
    }

    if (mark === "X") {
      this.grid[pos[0]][pos[1]] = 1
    } else {
      this.grid[pos[0]][pos[1]] = -1
    }

    return true;
  }
}
module.exports = Board;
