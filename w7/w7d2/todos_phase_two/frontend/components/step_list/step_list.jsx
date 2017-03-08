import React from "react";
import { stepsByTodoId } from "../../reducers/selectors";
import StepListItemContainer from "./step_list_item_container";
import StepForm from "./step_form";
// import { receiveTodo } from "../../actions/todo_actions";

class StepList extends React.Component {
  constructor(props) {
    super(props);
    this.props = props;
    // console.log(props);
  }
  componentDidMount() {
    this.props.fetchSteps();
  }
  render() {
    let stepsArr = this.props.steps;
    console.log(stepsArr);
    // console.log(this.props);
    let rows = [];
    for (let i = 0; i < stepsArr.length; i++) {
      rows.push(<StepListItemContainer todoId={this.props.todoId} receiveStep={this.props.receiveStep} removeStep={this.props.removeStep} step={stepsArr[i]} key={i}/>);
    }

    return (
      <div>
        <ul>{rows}</ul>
        <br />
        <StepForm error={this.props.error} clearErrors={this.props.clearErrors} createStep={this.props.createStep} todoId={this.props.todoId} receiveStep={this.props.receiveStep}/>
      </div>

    );
  }
}

export default StepList;
