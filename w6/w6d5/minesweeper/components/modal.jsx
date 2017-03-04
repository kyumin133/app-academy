import React from 'react';

class Modal extends React.Component {
  constructor(props) {
    super(props);
    this.props = props;
    // this.restartGame = this.restartGame.bind(this);
  }

  // restartGame() {
  //   this.props.restartGame();
  // }

  render() {
    // console.log(this.props.restartGame);
    return <div className="modal">
        <div className="modal-msg">
          <p>
            {this.props.msg}
          </p>
          <button type="button" onClick={this.props.restartGame}>
            Play again
          </button>
        </div>
      </div>;
  }
}

export default Modal;
