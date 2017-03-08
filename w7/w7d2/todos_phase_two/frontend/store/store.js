import { createStore, applyMiddleware } from 'redux';
import rootReducer from '../reducers/root_reducer';
import todosReducer from '../reducers/todos_reducer';
import { thunkMiddleware } from '../middleware/thunk';

const configureStore = createStore(rootReducer, {}, applyMiddleware(thunkMiddleware));

export default configureStore;
