import { connect } from "react-redux";
import StepList from "./step_list";
import { stepsByTodoId } from "../../reducers/selectors";
import { receiveStep } from "../../actions/step_actions";

const mapStateToProps = (state, params) => ({
  steps: stepsByTodoId(state, params.todoId)
});

const mapDispatchToProps = dispatch => ({
  receiveStep: (step) => dispatch(receiveStep(step)),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(StepList);
