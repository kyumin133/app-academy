const Util = require("./utils.js");
const MovingObject = require("./moving_object.js");
const Asteroid = require("./asteroid.js");

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
