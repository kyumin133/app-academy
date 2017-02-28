const SnakeClasses = require('./snake.js');
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
