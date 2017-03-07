import React from "react";
import StepListContainer from "../step_list/step_list_container";

class TodoDetailView extends React.Component {
  constructor(props) {
    super(props);
    this.props = props;
    // console.log(props);
    this.removeTodo = this.removeTodo.bind(this);
  }

  removeTodo(e) {
    this.props.removeTodo(this.props.todo);
  }

  render() {
    return (
      <div>
        <StepListContainer todoId={this.props.todo.id}/>
        <button onClick={this.removeTodo}>
          Delete
        </button>
        <br />
      </div>
    );
  }
}

export default TodoDetailView;
