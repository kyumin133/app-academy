import { connect } from "react-redux";
import TodoList from "./todo_list";
import { allTodos } from "../../reducers/selectors";
import { receiveTodo, removeTodo, fetchTodos, createTodo, updateTodo } from "../../actions/todo_actions";
import { fetchTags } from "../../actions/tag_actions";
import { clearErrors } from "../../actions/error_actions";

const mapStateToProps = state => ({
  todos: allTodos(state),
  error: state.error,
  tags: state.tags
});

const mapDispatchToProps = dispatch => ({
  receiveTodo: (todo) => dispatch(receiveTodo(todo)),
  removeTodo: (todo) => dispatch(removeTodo(todo)),
  fetchTodos: () => dispatch(fetchTodos()),
  createTodo: (todo) => dispatch(createTodo(todo)),
  updateTodo: (todo) => dispatch(updateTodo(todo)),
  clearErrors: () => dispatch(clearErrors()),
  fetchTags: () => dispatch(fetchTags())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
