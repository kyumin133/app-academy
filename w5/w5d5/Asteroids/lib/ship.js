const Util = require("./utils.js");
const MovingObject = require("./moving_object.js");
const Bullet = require("./bullet.js");


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
