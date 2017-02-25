const Asteroid = require("./asteroid.js");
const Ship = require("./ship.js");
const Bullet = require("./bullet.js");

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
