const directions = ["N", "E", "S", "W"];

class Snake {

  constructor() {
    this.direction = directions[0];
    this.segments = [new Coord([2, 2])];
  }

  move() {
    for (let i = 0; i < this.segments.length; i++) {
      this.segments[i] = this.segments[i].plus(this.direction);
    }
  }

  turn(newDirection) {
    if (this.opposite() === newDirection) {
      return;
    } else {
      this.direction = newDirection;
    }
  }

  opposite() {
    switch(this.direction) {
      case "N":
        return "S";
      case "E":
        return "W";
      case "S":
        return "N";
      case "W":
        return "E";
      }
  }

  directions() {
    return directions;
  }
}

class Coord {
  constructor(pos) {
    this.pos = pos;
  }

  plus(direction) {
    switch(direction) {
      case "N":
        return new Coord([this.pos[0] - 1, this.pos[1]]);
      case "E":
        return new Coord([this.pos[0], this.pos[1] + 1]);
      case "S":
        return new Coord([this.pos[0] + 1, this.pos[1]]);
      case "W":
        return new Coord([this.pos[0], this.pos[1] - 1]);
    }
  }

  equals(otherCoord) {
    return ((this.pos[0] === otherCoord.pos[0]) && (this.pos[1] === otherCoord.pos[1]));
  }
}

class Board {
  constructor() {
    // this.grid = [[]];
    this.snake = new Snake();
  }
}

module.exports = {
  Board: Board,
  Coord: Coord
};
