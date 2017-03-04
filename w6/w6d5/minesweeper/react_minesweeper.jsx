import React from 'react';
import ReactDOM from 'react-dom';
import Game from './components/game';

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("root");

  ReactDOM.render(
    <div>
      <h1 className="title">Minesweeper</h1>
      <Game />
      <p className="instructions">(alt-click to flag)</p>
    </div>, root);
});
