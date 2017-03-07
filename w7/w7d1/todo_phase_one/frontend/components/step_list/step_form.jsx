import React from 'react';
import { uniqueId } from '../../util/util';


class StepForm extends React.Component {
  constructor(props) {
    super(props);

    this.props = props;
    // console.log(this.props);
    this.state = {
      id: uniqueId(),
      title: "",
      body: "",
      done: "undone",
      todo_id: this.props.todoId
    };
    this.createStep = this.createStep.bind(this);
    this.changeTitle = this.changeTitle.bind(this);
    this.changeBody = this.changeBody.bind(this);
  }

  resetState() {
    this.setState({
      id: uniqueId(),
      title: "",
      body: "",
      done: "undone",
      todo_id: this.props.todoId
    });
  }
  createStep(e) {
    e.preventDefault();
    this.props.receiveStep(this.state);
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

        <button onClick={this.createStep}>Create</button>
      </form>
    );
  }
}
export default StepForm;
