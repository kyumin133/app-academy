import merge from 'lodash/merge';
import { RECEIVE_ERRORS, CLEAR_ERRORS } from "../actions/error_actions";

// reducers/steps_reducer.js
const initialState = [];

const errorReducer = (state = initialState, action) => {
  Object.freeze(state);
  let newState = merge({}, state);
  switch(action.type) {
    case RECEIVE_ERRORS:
      newState = action.errors;
      return newState;
    case CLEAR_ERRORS:
      newState = [];
      return newState;
    default:
      return state;
  }
};

export default errorReducer;
