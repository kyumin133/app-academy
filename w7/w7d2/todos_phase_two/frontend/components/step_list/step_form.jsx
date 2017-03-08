import React from 'react';
import { uniqueId } from '../../util/util';


class StepForm extends React.Component {
  constructor(props) {
    super(props);

    this.props = props;
    // console.log(this.props);
    this.state = {
      title: "",
      body: "",
      done: false,
      todo_id: this.props.todoId
    };
    this.createStep = this.createStep.bind(this);
    this.changeTitle = this.changeTitle.bind(this);
    this.changeBody = this.changeBody.bind(this);
  }

  resetState() {
    this.setState({
      title: "",
      body: "",
      done: false,
      todo_id: this.props.todoId
    });
    this.props.clearErrors();
  }
  createStep(e) {
    e.preventDefault();
    this.props.createStep(this.state).then(
      () => {
        this.resetState();
      }
    );
  }

  changeTitle(e) {
    this.setState({title: e.target.value});
  }

  changeBody(e) {
    this.setState({body: e.target.value});
  }

  render(){
    let error = "";
    let errorArr = this.props.error;
    if (errorArr.length > 0) {
      let errorUl = [];
      for (let i = 0; i < errorArr.length; i++) {
        errorUl.push(<li key={i}>{errorArr[i]}</li>);
      }
      error = <ul>{errorUl}</ul>;
    }
    return (
      <div>
        {error}
        <form>
          <input type="text" value={this.state.title} onChange={this.changeTitle} placeholder="Title"></input>
          <input type="text" value={this.state.body} onChange={this.changeBody} placeholder="Body"></input>

          <button onClick={this.createStep}>Create</button>
        </form>
      </div>
    );
  }
}
export default StepForm;
