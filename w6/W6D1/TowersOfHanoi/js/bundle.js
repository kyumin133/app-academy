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
/******/ 	return __webpack_require__(__webpack_require__.s = 1);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

class Game {
  constructor() {
    this.towers = [[3, 2, 1], [], []];
  }

  isValidMove(startTowerIdx, endTowerIdx) {
      const startTower = this.towers[startTowerIdx];
      const endTower = this.towers[endTowerIdx];

      if (startTower.length === 0) {
        return false;
      } else if (endTower.length == 0) {
        return true;
      } else {
        const topStartDisc = startTower[startTower.length - 1];
        const topEndDisc = endTower[endTower.length - 1];
        return topStartDisc < topEndDisc;
      }
  }

  isWon() {
      // move all the discs to the last or second tower
      return (this.towers[2].length == 3) || (this.towers[1].length == 3);
  }

  move(startTowerIdx, endTowerIdx) {
      if (this.isValidMove(startTowerIdx, endTowerIdx)) {
        this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
        return true;
      } else {
        return false;
      }
  }

  print() {
      console.log(JSON.stringify(this.towers));
  }

  promptMove(reader, callback) {
      this.print();
      reader.question("Enter a starting tower: ", start => {
        const startTowerIdx = parseInt(start);
        reader.question("Enter an ending tower: ", end => {
          const endTowerIdx = parseInt(end);
          callback(startTowerIdx, endTowerIdx)
        });
      });
  }

  run(reader, gameCompletionCallback) {
      this.promptMove(reader, (startTowerIdx, endTowerIdx) => {
        if (!this.move(startTowerIdx, endTowerIdx)) {
          console.log("Invalid move!");
        }

        if (!this.isWon()) {
          // Continue to play!
          this.run(reader, gameCompletionCallback);
        } else {
          this.print();
          console.log("You win!");
          gameCompletionCallback();
        }
      });
  }
}

module.exports = Game;


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const HanoiGame = __webpack_require__(0);
const HanoiView = __webpack_require__(2);

// console.log(HanoiGame);

$( () => {
  const rootEl = $('.hanoi');
  const game = new HanoiGame();
  new HanoiView(game, rootEl);
});


/***/ }),
/* 2 */
/***/ (function(module, exports) {

class View {
  constructor(game, dom) {
    this.game = game;
    this.dom = dom;
    // this.setupTowers();
    this.render();
    this.bindEvents();
  }

  // setupTowers() {
  //   let towers = this.game.towers;
  //   for (let i = 0; i < 3; i++) {
  //     let tower = towers[i];
  //     let $ul = $("<ul>");
  //
  //     $ul.data("tower", i);
  //     $ul.addClass("tower");
  //
  //     for (let j = tower.length - 1; j >= 0; j--) {
  //       let $li = $("<li>");
  //       $li.addClass(`disk-${tower[j]}`);
  //       $li.html(tower[j]);
  //       $ul.append($li);
  //     }
  //     $(this.dom).append($ul);
  //   }
  // }

  render() {
    let towers = this.game.towers;
    $(this.dom).empty();
    for (let i = 0; i < 3; i++) {
      let tower = towers[i];
      let $ul = $("<ul>");

      $ul.data("tower", i);
      $ul.addClass("tower");

      for (let j = tower.length - 1; j >= 0; j--) {
        let $li = $("<li>");
        $li.addClass(`disk disk-${tower[j]}`);
        $li.html(tower[j]);
        $ul.append($li);
      }
      $(this.dom).append($ul);
    }
  }

  bindEvents() {
    let game = this.game;
    let view = this;
    $(".tower").on("click", function(e1) {
      if (game.isWon()) {
        return;
      }

      let $startTower = $(e1.currentTarget);
      $startTower.addClass("clicked");

      $(".tower").on("click", function(e2) {
        let $endTower = $(e2.currentTarget);

        view.makeMove($startTower, $endTower);


        $startTower.removeClass("clicked");
        $('.tower').off('click');
        view.bindEvents();
      });

    });
  }

  makeMove($startTower, $endTower) {
    let result = this.game.move($startTower.data("tower"), $endTower.data("tower"));
    if (result) {
      this.render();
      if (this.game.isWon()) {
        $(".disk").addClass("disabled-disk");
        $(".tower").addClass("disabled-tower");
        alert("You win!");
      }
    } else {
      alert("Invalid move.");
    }
  }
}

module.exports = View;


/***/ })
/******/ ]);