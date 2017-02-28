/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.l = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };

/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};

/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};

/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const Board = __webpack_require__(1);
const View = __webpack_require__(2);

$( () => {
  // Your code here
  let view = new View($(".snake"));
});


/***/ }),
/* 1 */
/***/ (function(module, exports) {

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


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const SnakeClasses = __webpack_require__(1);
const keyPresses = [38, 39, 40, 37];

class View {
  constructor($el) {
    this.$el = $el;
    this.board = new SnakeClasses.Board();
    this.bindEvents();

    let view = this;
    view.render();
    // window.setInterval(function() {
    //   view.render();
    // }, 500);
  }

  bindEvents() {
    let snake = this.board.snake;
    $(window).on("keydown", function (e) {
      let index = keyPresses.indexOf(e.which);
      if (index === -1) {
        return;
      } else {
        let newDirection = snake.directions()[index];
        snake.turn(newDirection);
      }
    });
  }

  render() {
    this.$el.empty();

    let $ul = $("<ul>");
    $ul.addClass("board");

    let segments = this.board.snake.segments;

    for (let i = 0; i < 5; i++) {
      for (let j = 0; j < 5; j++) {
        let $li = $("<li>");
        $li.addClass("tile");
        $li.attr('id', `tile-${i}-${j}`);
        $li.html(`${i}, ${j}`);

        let pos = new SnakeClasses.Coord([i, j]);

        for (let k = 0; k < segments.length; k++) {
          if (pos.equals(segments[k])) {
            $li.addClass("snake-tile");
          }
        }
        $ul.append($li);
      }
    }
    //
    // let segments = this.board.snake.segments;
    // $("#tile-2-2").addClass("snake-tile");
    // for (let i = 0; i < segments.length; i++) {
    //   let pos = segments[i].pos;
    //   console.log(pos[0]);
    //   let id = `tile-${pos[0]}-${pos[1]}`;
    //   $("#" + id).addClass("snake-tile");
    //   // console.log($(id));
    //   // console.log(`#tile-${pos[0]}-${pos[1]}`);
    // }

    this.$el.append($ul);
  }
}


module.exports = View;


/***/ })
/******/ ]);