import React from 'react';
import { uniqueId } from '../../util/util';


class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    
    this.props = props;
    this.state = {
      id: uniqueId(),
      title: "",
      body: "",
      done: "undone"
    };
    this.createTodo = this.createTodo.bind(this);
    this.changeTitle = this.changeTitle.bind(this);
    this.changeBody = this.changeBody.bind(this);
  }

  resetState() {
    this.setState({
      id: uniqueId(),
      title: "",
      body: "",
      done: "undone"
    });
  }
  createTodo(e) {
    e.preventDefault();
    this.props.receiveTodo(this.state);
    this.resetState();
  }

  changeTitle(e) {
    this.setState({title: e.target.value});
  }

  changeBody(e) {
    this.setState({body: e.target.value});
  }

  render(){
    return (
      <form>
        <input type="text" value={this.state.title} onChange={this.changeTitle} placeholder="Title"></input>
        <input type="text" value={this.state.body} onChange={this.changeBody} placeholder="Body"></input>

        <button onClick={this.createTodo}>Create</button>
      </form>
    );
  }
}
export default TodoForm;

//     id: 3,
//     title: "sell car",
//     body: "with soap",
//     done: false
//   },
