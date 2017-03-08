import { combineReducers } from 'redux';
import todosReducer from './todos_reducer';
import stepsReducer from './steps_reducer';
import errorReducer from './error_reducer';
import tagsReducer from './tags_reducer';

const RootReducer = combineReducers({todos: todosReducer, steps: stepsReducer, error: errorReducer, tags: tagsReducer});
export default RootReducer;
