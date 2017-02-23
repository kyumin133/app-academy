let Piece = require("./piece");

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  let grid = [];
  for (let i = 0; i < 8; i++) {
    let row = [];
    for (let j = 0; j < 8; j++) {
      row.push(null);
    }
    grid.push(row);
  }

  grid[3][4] = new Piece("black");
  grid[4][3] = new Piece("black");

  grid[3][3] = new Piece("white");
  grid[4][4] = new Piece("white");
  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  if (invalidPos(pos)) throw new Error("Invalid position");
  return this.grid[pos[0]][pos[1]];
};

function invalidPos(pos) {
  return (pos[0] < 0) || (pos[0] > 7) || (pos[1] < 0) || (pos[1] > 7);
}


Board.prototype.validMoves = function(color) {
  let validMoves = [];
  for (let i = 0; i < 8; i++) {
    for (let j = 0; j < 8; j++) {
      if (this.grid[i][j] !== null) {
        continue;
      }
      let piece = this.grid[i][j];
      let pos = [i, j];
      let adjOppDirs = this.adjacentOppDirections(pos, color);
      if (adjOppDirs.length === 0) {
        continue;
      }
      for (let k = 0; k < adjOppDirs.length; k++) {
        let dir = adjOppDirs[k];
        if (this.validDirection(pos, dir, color)) {
          validMoves.push(pos);
          break;
        }
      }
    }
  }
  return validMoves;
};
/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function(color) {
  return this.validMoves(color).length > 0;
};

Board.prototype.adjacentOppDirections = function(pos, color) {
  let dirs = [];
  for (let i = 0; i < Board.DIRS.length; i++) {
    let dir = Board.DIRS[i];
    let newPos = [pos[0] + dir[0], pos[1] + dir[1]];
    if (invalidPos(newPos)) {
      continue;
    }
    let piece = this.getPiece(newPos);
    if (piece === null) continue;
    if (piece.oppColor() === color) dirs.push(dir);
  }
  return dirs;
};

Board.prototype.validDirection = function(pos, dir, color) {
  let newPos = [pos[0] + dir[0], pos[1] + dir[1]];
  while (true) {
    newPos = [newPos[0] + dir[0], newPos[1] + dir[1]];
    if (invalidPos(newPos)) break;

    piece = this.getPiece(newPos);
    if (piece === null) return false;
    if (piece.color === color) return true;
  }
  return false;
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  let piece = this.getPiece(pos);
  if (piece === null) return false;
  return piece.color === color;
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
};

/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  return (!this.hasMove("black") && !this.hasMove("white"));
};

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  return !invalidPos(pos);
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns null if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns null if it hits an empty position.
 *
 * Returns null if no pieces of the opposite color are found.
 */
function _positionsToFlip (board, pos, color, dir, piecesToFlip) {
}

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  let validMoves = this.validMoves(color);
  if (!includesPos(validMoves, pos)) throw new Error("Invalid pos");

  this.grid[pos[0]][pos[1]] = new Piece(color);
  this.flipPieces(pos, color);
};

Board.prototype.flipPieces = function(pos, color) {
  let adjOppDirs = this.adjacentOppDirections(pos, color);

  for (let i = 0; i < adjOppDirs.length; i++) {
    let dir = adjOppDirs[i];
    if (this.validDirection(pos, dir, color)) {
      let newPos = [pos[0] + dir[0], pos[1] + dir[1]];
      while (true) {
        this.getPiece(newPos).flip();
        newPos = [newPos[0] + dir[0], newPos[1] + dir[1]];
        let newPiece = this.getPiece(newPos);
        if (newPiece === null) break;
        if (newPiece.color === color) break;
      }
    }
  }
}

function includesPos(moves, pos) {
  for (let i = 0; i < moves.length; i++) {
    if(moves[i][0] === pos[0] && moves[i][1] === pos[1]) return true;
  }
  return false;
}

/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  console.log("-----");
  printStr = ""
  for (let i = 0; i < 8; i++) {
    row = "";
    for (let j = 0; j < 8; j++) {
      piece = this.getPiece([i, j]);
      if (piece === null) {
        row = row.concat("*");
      } else {
        row = row.concat(piece.toString());
      }
    }
    console.log(row);
  }
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  return includesPos(this.validMoves(color), pos)
};

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */

module.exports = Board;
