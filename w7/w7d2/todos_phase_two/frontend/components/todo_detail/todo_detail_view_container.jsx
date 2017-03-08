import { connect } from "react-redux";
import TodoDetailView from "./todo_detail_view";
import { allTodos } from "../../reducers/selectors";
import { removeTodo, deleteTodo } from "../../actions/todo_actions";
import { receiveSteps } from "../../actions/step_actions";

const mapStateToProps = null;

const mapDispatchToProps = dispatch => ({
  removeTodo: (todo) => dispatch(removeTodo(todo)),
  deleteTodo: (todo) => dispatch(deleteTodo(todo)),
  receiveSteps: (steps) => dispatch(receiveSteps(steps))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoDetailView);
