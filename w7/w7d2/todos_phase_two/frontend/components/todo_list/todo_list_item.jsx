import React from "react";
import TodoDetailViewContainer from "../todo_detail/todo_detail_view_container";

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.props = props;    
    this.state = {
      detail: false
    };
    this.toggleDetail = this.toggleDetail.bind(this);
    this.updateTodo = this.updateTodo.bind(this);
    this.removeTodo = this.removeTodo.bind(this);
  }

  updateTodo(e) {
    this.props.todo.done = !this.props.todo.done;
    // console.log(this.props.todo);
    this.props.updateTodo(this.props.todo);
  }

  removeTodo(e) {
    this.props.removeTodo(this.props.todo);
  }

  toggleDetail(e) {
    this.state.detail ? this.setState({detail: false}) : this.setState({detail: true});
  }

  render() {
    let doneUndo = (this.props.todo.done) ? "Undo" : "Done";
    let container = (this.state.detail) ? <TodoDetailViewContainer deleteTodo={this.props.deleteTodo} todo={this.props.todo}/> : "";
    return <li>
      <span className="details" onClick={this.toggleDetail}>
        {this.props.todo.title}
      </span>

      <button onClick={this.updateTodo}>
        {doneUndo}
      </button>
      {container}

    </li>;
  }
}

export default TodoListItem;
