export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";
import { fetchTodosUtil, createTodoUtil, updateTodoUtil, deleteTodoUtil } from '../util/todo_api_util';
import { receiveErrors } from './error_actions';

export const fetchTodos = function() {
  return (dispatch) => {
    return fetchTodosUtil().then((response) => {
      let newState = {};
      for (let i = 0; i < response.length; i++) {
        newState[response[i].id] = response[i];
      }
      return dispatch(receiveTodos(newState));
    });
  };
};


// export const createTodo = function(todo) {
//   // console.log(todo);
//   return (dispatch) => {
//     // console.log(createTodoUtil(todo));
//     return createTodoUtil(todo).then((response) => {
//       return dispatch(receiveTodo(response));
//     });
//   };
// };
export function createTodo(todo) {
  return (dispatch) => {
    return createTodoUtil(todo)
      .then(response => dispatch(receiveTodo(response)),
            err => dispatch(receiveErrors(err.responseJSON)));
  };
}

export function updateTodo(todo) {
  return (dispatch) => {
    return updateTodoUtil(todo)
      .then(response => dispatch(receiveTodo(response)),
            err => dispatch(receiveErrors(err.responseJSON)));
  };
}

export function deleteTodo(todo) {
  return (dispatch) => {
    return deleteTodoUtil(todo)
      .then(response => {
              dispatch(removeTodo(todo));
            },
            err => dispatch(receiveErrors(err.responseJSON)));
  };
}

export const receiveTodos = function(todos) {
  return {
    type: RECEIVE_TODOS,
    todos: todos
  };
};

export const receiveTodo = function(todo) {
  return {
    type: RECEIVE_TODO,
    todo: todo
  };
};

export const removeTodo = function(todo) {
  return {
    type: REMOVE_TODO,
    todo: todo
  };
};
