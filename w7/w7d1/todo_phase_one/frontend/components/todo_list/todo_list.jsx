import React from "react";
import { allTodos } from "../../reducers/selectors";
import TodoListItem from "./todo_list_item";
import TodoForm from "./todo_form";
// import { receiveTodo } from "../../actions/todo_actions";

class TodoList extends React.Component {
  constructor(props) {
    super(props);
    this.props = props;
    // console.log(props);
  }

  render() {
    let todosArr = allTodos(this.props);
    // console.log(this.props);
    let rows = [];
    for (let i = 0; i < todosArr.length; i++) {
      rows.push(<TodoListItem receiveTodo={this.props.receiveTodo} removeTodo={this.props.removeTodo} todo={todosArr[i]} key={i}/>);
    }

    return (
      <div>
        <ul>{rows}</ul>
        <br />
        <TodoForm receiveTodo={this.props.receiveTodo}/>
      </div>

    );
  }
}

export default TodoList;
