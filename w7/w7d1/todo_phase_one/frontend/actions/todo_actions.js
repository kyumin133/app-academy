export const RECEIVE_TODOS = "RECIEVE_TODOS";
export const RECEIVE_TODO = "RECIEVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";

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
