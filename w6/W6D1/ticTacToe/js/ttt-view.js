class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.$el.append(this.setupBoard());
    this.bindEvents();
  }

  bindEvents() {
    // $(".square").on("click", (event) => this.game.playMove($(event.currentTarget).data('pos')));
    let game = this.game;
    let view = this;
    $(".square").on("click", function(e) {
      if (game.isOver()) {
        return;
      }

      view.makeMove($(e.currentTarget));

    });
  }

  makeMove($square) {
    // let $square = $(e.currentTarget);
    let game = this.game;
    let pos = $square.data('pos');
    let player = game.currentPlayer;

    try {
      game.playMove(pos);
    } catch(err) {
      alert("Invalid move.");
      return;
    }


    $square.html(player);
    $square.data("player", player);
    $square.removeClass("active");
    $square.addClass("inactive");
    $square.addClass("clicked");

    if (game.isOver()) {
      let winner = game.winner();

      $("li").each(function () {
        if ($(this).data("player") === winner) {
          $(this).addClass("won");
        } else {
          $(this).addClass("notWon");
        }
        $(this).removeClass("active");
        $(this).addClass("inactive");
      });

      if (winner === null) {
        this.$el.append(`<h2>It's a draw.</h2>`);
      } else {
        this.$el.append(`<h2>${winner} has won!</h2>`);
      }
    }

  }

  setupBoard() {
    let $el = $("<ul>");
    $el.addClass("board");

    for (let i = 0; i < 9; i++ ) {
      let $li = $('<li>');
      $li.addClass("square");
      $li.addClass("active");
      $li.data("pos", [Math.floor(i / 3), i % 3]);
      $el.append($li);
    }

    return $el;
  }
}

// $('li').each(function () { console.log($(this).data('pos')) } )

module.exports = View;
