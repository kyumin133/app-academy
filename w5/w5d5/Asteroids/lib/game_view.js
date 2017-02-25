const Game = require("./game.js");

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
