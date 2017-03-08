import React from 'react';
import ReactDOM from 'react-dom';
import Root from './frontend/components/root';
import configureStore from './frontend/store/store';
import { allTodos, stepsByTodoId } from './frontend/reducers/selectors';


document.addEventListener("DOMContentLoaded", function(){
  let store = configureStore;
  window.store = store;
  console.log(window.store.getState());
  // console.log(stepsByTodoId(window.store.getState(), 2));

  ReactDOM.render(<Root store={store}/>, document.getElementById("content"));
});






//
// const newTodos = {
//   3: {
//     id: 3,
//     title: "sell car",
//     body: "with soap",
//     done: false
//   },
//   4: {
//     id: 4,
//     title: "feed dog",
//     body: "with shampoo",
//     done: true
//   }
// };
