import React from 'react';
import Board from './board';
import Modal from './modal';
import * as Minesweeper from '../minesweeper';

class Game extends React.Component {
  constructor(props) {
    super(props);

    let board = new Minesweeper.Board(9, 10);
    this.state = {
      board: board,
      showModal: false,
      modal: ""
    };

    this.updateGame = this.updateGame.bind(this);
    this.restartGame = this.restartGame.bind(this);
  }

  restartGame() {
    this.setState({
      board: new Minesweeper.Board(9, 10),
      showModal: false,
      modal: ""
    });
  }

  updateGame(tile, flagged) {
    if (flagged) {
      tile.toggleFlag();
    } else {
      tile.explore();
    }

    let modal = ""
    let showModal = false;
    if (this.state.board.lost()) {
      showModal = true;
      modal = "You lose."
    } else if (this.state.board.won()) {
      showModal = true;
      modal = "You win!"
    }
    this.setState({
      board: this.state.board,
      showModal: showModal,
      modal: modal
    });
  }

  render() {
    if (this.state.showModal) {
      return  <div className="game">
                <Board board={this.state.board} updateGame={this.updateGame}/>
                <Modal msg={this.state.modal} restartGame={this.restartGame}/>
              </div>
    } else {
      return <div className="game"><Board board={this.state.board} updateGame={this.updateGame}/></div>;
    }
  }
}

export default Game;
