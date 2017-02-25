const Util = require("./utils.js");
const MovingObject = require("./moving_object.js");
const Ship = require("./ship.js");
const Bullet = require("./bullet.js");

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
