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
