import React from 'react';

class Tile extends React.Component {
  constructor(props) {
    super(props);

    this.props = props;

    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(e) {
    let flagged = e.altKey
    // console.log(flagged);
    this.props.updateGame(this.props.tile, flagged);
  }

  render() {
    let tile = this.props.tile;
    let text = "";
    let className = "tile";
    if (tile.explored) {
      className = "tile explored"
      if (tile.bombed) {
        text = "\uD83D\uDCA3";
        className = className.concat(" bombed")
      } else if (tile.adjacentBombCount() > 0) {
        let numBombs = tile.adjacentBombCount();
        text = numBombs.toString();
        className = className.concat(` tile-${numBombs}`)
      }
    } else if (tile.flagged) {
      text = "\uD83D\uDEA9";
    }
    // console.log(text);

    if (text === "") {
      text = "*";
      className = className.concat(" hidden");
    }
    return (<div onClick={this.handleClick} className={className}>{text}</div>);
  }
}

export default Tile;
