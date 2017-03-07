import React from 'react';
import TodoListContainer from './todo_list/todo_list_container';

class App extends React.Component {
  constructor(props) {
    super(props);
    
  }
  render() {
    return <TodoListContainer />;
  }
}

export default App;
