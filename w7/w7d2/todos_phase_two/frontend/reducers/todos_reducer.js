import merge from 'lodash/merge';
import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO } from "../actions/todo_actions";

// reducers/todos_reducer.js
const initialState = {};

const todosReducer = (state = initialState, action) => {
  Object.freeze(state);
  let newState = merge({}, state);
  switch(action.type) {
    case RECEIVE_TODOS:
      newState = action.todos;
      console.log(newState);
      return newState;
    case RECEIVE_TODO:
      newState[action.todo.id] = action.todo;
      console.log(newState);
      return newState;
    case REMOVE_TODO:
      console.log(newState);
      console.log(action.todo.id);
      delete newState[action.todo.id];
      console.log(newState);
      return newState;
    default:
      return state;
  }
};

export default todosReducer;
