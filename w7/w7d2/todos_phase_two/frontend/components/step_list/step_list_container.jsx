import { connect } from "react-redux";
import StepList from "./step_list";
import { stepsByTodoId } from "../../reducers/selectors";
import { receiveStep, fetchSteps, createStep } from "../../actions/step_actions";
import { clearErrors } from "../../actions/error_actions";

const mapStateToProps = (state, params) => ({
  steps: stepsByTodoId(state, params.todoId),
  error: state.error
});

const mapDispatchToProps = dispatch => ({
  receiveStep: (step) => dispatch(receiveStep(step)),
  fetchSteps: () => dispatch(fetchSteps()),
  createStep: (step) => dispatch(createStep(step)),
  clearErrors: () => dispatch(clearErrors())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(StepList);
