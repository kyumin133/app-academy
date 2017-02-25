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
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	__webpack_require__(6);
	__webpack_require__(5);
	__webpack_require__(8);
	__webpack_require__(7);
	__webpack_require__(3);
	__webpack_require__(4);
	module.exports = __webpack_require__(2);


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(2);
	const MovingObject = __webpack_require__(3);
	const Ship = __webpack_require__(4);
	const Bullet = __webpack_require__(5);

	function Asteroid(pos, game) {
	  let radius = 5;
	  let color = "#00FF00";


	  MovingObject.apply(this, [{pos: pos, game: game, radius: radius, color: color, vel: Util.randomVec(5)}]);
	}


	Util.inherits(Asteroid, MovingObject);

	Asteroid.prototype.collideWith = function(otherObject) {
	  if (otherObject instanceof Ship) {
	    otherObject.relocate();
	  } else if (otherObject instanceof Bullet) {
	    this.game.remove(this);
	  }
	};

	module.exports = Asteroid;


/***/ },
/* 2 */
/***/ function(module, exports) {

	const Util = {
	  inherits (childClass, parentClass) {
	    childClass.prototype = Object.create(parentClass.prototype);
	    childClass.prototype.constructor = childClass;
	  },

	  randomVec (length) {
	    const deg = 2 * Math.PI * Math.random();
	    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
	  },
	  // Scale the length of a vector by the given amount.
	  scale (vec, m) {
	    return [vec[0] * m, vec[1] * m];
	  },

	  distanceBetween (pos1, pos2) {
	    let dx = pos1[0] - pos2[0];
	    let dy = pos1[1] - pos2[1];
	    return Math.sqrt((dx * dx) + (dy * dy));
	  }

	};

	module.exports = Util;


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(2);

	function MovingObject(options) {
	  this.pos = options["pos"];
	  this.vel = options["vel"];
	  this.radius = options["radius"];
	  this.color = options["color"];
	  this.game = options["game"];
	}

	MovingObject.prototype.isWrappable = true;

	MovingObject.prototype.draw = function(ctx) {
	  ctx.fillStyle = this.color;
	  ctx.beginPath();

	  ctx.arc(
	    this.pos[0],
	    this.pos[1],
	    this.radius,
	    0,
	    2 * Math.PI,
	    false
	  );

	  ctx.fill();
	};

	MovingObject.prototype.move = function() {
	  this.pos[0] += this.vel[0];
	  this.pos[1] += this.vel[1];

	  if (this.game.isOutOfBounds(this.pos)) {
	    if (this.isWrappable) {
	      this.pos = this.game.wrap(this.pos);
	    } else {
	      this.game.remove(this);
	    }
	  }
	};

	MovingObject.prototype.isCollidedWith = function(otherObject) {
	  let distance = Util.distanceBetween(this.pos, otherObject.pos);
	  let sumRadii = this.radius + otherObject.radius;
	  return (distance < sumRadii);
	};

	MovingObject.prototype.collideWith = function(otherObject) {

	};


	module.exports = MovingObject;


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(2);
	const MovingObject = __webpack_require__(3);
	const Bullet = __webpack_require__(5);


	function Ship(pos, game) {
	  let radius = 15;
	  let color = "#FF0000";
	  let vel = [0, 0];


	  MovingObject.apply(this, [{pos: pos, vel: vel, radius: radius, color: color, game: game}]);

	}
	Util.inherits(Ship, MovingObject);

	Ship.prototype.relocate = function() {
	  this.pos = this.game.randomPosition();
	  this.vel = [0, 0];
	};

	Ship.prototype.power = function(impulse) {
	  this.vel[0] += impulse[0];
	  this.vel[1] += impulse[1];
	};



	Ship.prototype.collideWith = function(otherObject) {
	  // if (otherObject instanceof Asteroid) {
	  //   this.relocate();
	  // }
	};

	Ship.prototype.fireBullet = function() {
	  let bullet = new Bullet(this.vel, this.pos.slice(), this.game);
	  // console.log(bullet);
	  this.game.bullets.push(bullet);
	};
	module.exports = Ship;


/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(2);
	const MovingObject = __webpack_require__(3);
	const Asteroid = __webpack_require__(1);

	const defaultVel = [0, -10];
	const multiplier = 10;

	function Bullet(vel, pos, game) {
	  let radius = 2;
	  let color = "#000000";

	  let normVel = this.normalizeVelocity(vel);
	  // let normVel = defaultVel;
	  MovingObject.apply(this, [{pos: pos, game: game, radius: radius, color: color, vel: normVel}]);
	}


	Util.inherits(Bullet, MovingObject);

	Bullet.prototype.isWrappable = false;

	Bullet.prototype.collideWith = function(otherObject) {

	};

	Bullet.prototype.normalizeVelocity = function(vel) {
	  let magnitude = Math.sqrt((vel[0] * vel[0]) + (vel[1] * vel[1]));
	  if (magnitude === 0) {
	    return defaultVel;
	  } else {
	    return [multiplier * vel[0] / magnitude, multiplier * vel[1] / magnitude];
	  }
	};

	module.exports = Bullet;


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	const GameView = __webpack_require__(7);

	document.addEventListener("DOMContentLoaded", function(event) {
	  let canvas = document.getElementById("game-canvas");
	  let ctx = canvas.getContext("2d");
	  let gv = new GameView(ctx);
	  gv.start();
	});


/***/ },
/* 7 */
/***/ function(module, exports, __webpack_require__) {

	const Game = __webpack_require__(8);

	function GameView(ctx) {
	  this.game = new Game();
	  this.ctx = ctx;
	}

	GameView.prototype.start = function() {
	  let gv = this;
	  this.bindKeyHandlers(this.game);
	  setInterval(function() {
	    gv.game.step();
	    gv.game.draw(gv.ctx);
	  }, 20);
	};

	GameView.prototype.bindKeyHandlers = function(game) {
	  key('w', function(){ game.ship.power([0, -1]) });
	  key('up', function(){ game.ship.power([0, -1]) });

	  key('a', function(){ game.ship.power([-1, 0]) });
	  key('left', function(){ game.ship.power([-1, 0]) });

	  key('s', function(){ game.ship.power([0, 1]) });
	  key('down', function(){ game.ship.power([0, 1]) });

	  key('d', function(){ game.ship.power([1, 0]) });
	  key('right', function(){ game.ship.power([1, 0]) });

	  key('space', function() { game.ship.fireBullet()});
	};

	module.exports = GameView;


/***/ },
/* 8 */
/***/ function(module, exports, __webpack_require__) {

	const Asteroid = __webpack_require__(1);
	const Ship = __webpack_require__(4);
	const Bullet = __webpack_require__(5);

	const DIM_X = 1000;
	const DIM_Y = 500;
	const NUM_ASTEROIDS = 15;
	function Game() {

	  this.asteroids = [];
	  this.addAsteroids();
	  this.addShip();
	  this.bullets = [];
	}

	Game.prototype.allObjects = function() {
	  return this.asteroids.concat(this.ship).concat(this.bullets);
	};

	Game.prototype.addAsteroids = function() {
	  for (let i = 0; i < NUM_ASTEROIDS; i++) {
	    this.asteroids.push(new Asteroid(this.randomPosition(), this));
	  }
	};

	Game.prototype.addShip = function() {
	  let shipPos = this.randomPosition();

	  this.ship = new Ship(shipPos, this);

	};

	Game.prototype.randomPosition = function() {
	  return [(Math.random() * DIM_X), (Math.random() * DIM_Y)];
	};

	Game.prototype.draw = function(ctx) {
	  ctx.clearRect(0, 0, 1000, 500);
	  let allObjects = this.allObjects();

	  for (let i = 0; i < allObjects.length; i++) {
	    allObjects[i].draw(ctx);
	  }
	};

	Game.prototype.moveObjects = function() {
	  let allObjects = this.allObjects();
	  for (let i = 0; i < allObjects.length; i++) {
	    allObjects[i].move();
	  }
	};

	Game.prototype.isOutOfBounds = function(pos) {
	  return ((pos[0] < 0) || (pos[0] > DIM_X) || (pos[1] < 0) || (pos[1] > DIM_Y));
	};

	Game.prototype.wrap = function(pos) {
	  if (pos[0] < 0) {
	    pos[0] += DIM_X;
	  } else if (pos[0] > DIM_X) {
	    pos[0] -= DIM_X;
	  }

	  if (pos[1] < 0) {
	    pos[1] += DIM_Y;
	  } else if (pos[1] > DIM_Y) {
	    pos[1] -= DIM_Y;
	  }

	  return pos;
	};

	Game.prototype.checkCollisions = function() {
	  let allObjects = this.allObjects();
	  for (let i = 0; i < allObjects.length - 1; i++) {
	    for (let j = i + 1; j < allObjects.length; j++) {
	      if (allObjects[i].isCollidedWith(allObjects[j])) {
	        allObjects[i].collideWith(allObjects[j]);
	      }
	    }
	  }
	};

	Game.prototype.step = function() {
	  this.moveObjects();
	  this.checkCollisions();
	};

	Game.prototype.remove = function(obj) {
	  if (obj instanceof Asteroid) {
	    this.asteroids.splice(this.asteroids.indexOf(obj), 1);
	  } else if (obj instanceof Bullet) {
	    this.bullets.splice(this.bullets.indexOf(obj), 1);
	  }
	};

	module.exports = Game;


/***/ }
/******/ ]);