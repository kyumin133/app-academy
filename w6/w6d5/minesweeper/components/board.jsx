import React from 'react';
import Tile from './tile';

class Board extends React.Component {
  constructor(props) {
    super(props);

    this.props = props;
  }

  render() {
    let rows = [];

    let board = this.props.board;
    for (let i = 0; i < board.grid.length; i++) {
      let mapped = board.grid[i].map((el, idx) => {
        return <Tile key={idx} tile={el} updateGame={this.props.updateGame}/>;
      });
      let row = <div className="row" key={i}>{mapped}</div>;
      rows.push(row);
    }

    return <div className="board">{rows}</div>;
  }
}

export default Board;
