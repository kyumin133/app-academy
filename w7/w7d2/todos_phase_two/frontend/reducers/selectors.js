export const allTodos = function(state) {
  // console.log(state);
  // console.log(state.todos);
  let todosArr = Object.keys(state.todos).map((key) => {
    return state.todos[key];
  });

  // console.log(state);
  return todosArr;
};

export const stepsByTodoId = function(state, todoId) {

  let stepsArr = Object.keys(state.steps).map((key) => {
    return state.steps[key];
  });

  let matches = [];
  for (let i = 0; i < stepsArr.length; i++) {
    // console.log(stepsArr[i]);
    // console.log(todoId);
    if (stepsArr[i].todo_id === todoId) {
      matches.push(stepsArr[i]);
    }
  }

  // console.log(matches);
  return matches;
};

// export default allTodos;
