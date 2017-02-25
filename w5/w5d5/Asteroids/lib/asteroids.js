const GameView = require("./game_view.js");

document.addEventListener("DOMContentLoaded", function(event) {
  let canvas = document.getElementById("game-canvas");
  let ctx = canvas.getContext("2d");
  let gv = new GameView(ctx);
  gv.start();
});
