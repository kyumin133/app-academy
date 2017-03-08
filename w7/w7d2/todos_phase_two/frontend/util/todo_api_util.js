export const fetchTodosUtil = () => {
  return $.ajax ({
    url: "api/todos",
    type: "GET",
    success: (response) => {
      // console.log(response);
      return response;
    }
  });
};


export const createTodoUtil = (todo) => {
  return $.ajax ({
    url: "api/todos",
    type: "POST",
    data: { todo },
    success: (response) => {
      // console.log(response);
      return response;
    },
    error: (err) => {
      // console.log(err.responseText);
      return err.responseText;
    }
  });
};

export const updateTodoUtil = (todo) => {
  return $.ajax ({
    url: `api/todos/${todo.id}`,
    type: "PATCH",
    data: { todo },
    success: (response) => {
      return response;
    },
    error: (err) => {
      // console.log(err.responseText);
      return err.responseText;
    }
  });
};

export const deleteTodoUtil = (todo) => {
  return $.ajax({
    url: `api/todos/${todo.id}`,
    type: "DELETE",
    success: (response) => {
      return response;
    },
    error: (err) => {
      return err.responseText;
    }
  });
};
