import React from "react";

class StepListItem extends React.Component {
  constructor(props) {
    super(props);
    this.props = props;
    // console.log(props);

    this.updateStep = this.updateStep.bind(this);
    this.removeStep = this.removeStep.bind(this);
  }

  updateStep(e) {
    this.props.step.done = !this.props.step.done;
    this.props.updateStep(this.props.step);
    // this.forceUpdate();
  }

  removeStep(e) {
    this.props.deleteStep(this.props.step);
  }

  render() {
    let doneUndo = (this.props.step.done) ? "Undo" : "Done";
    return <li>
      <span>{this.props.step.title}</span>
      <span>{this.props.step.body}</span>
      <button onClick={this.updateStep}>
        {doneUndo}
      </button>
      <button onClick={this.removeStep}>
        Delete
      </button>

    </li>;
  }
}

export default StepListItem;
