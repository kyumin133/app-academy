import merge from 'lodash/merge';
import { RECEIVE_STEPS, RECEIVE_STEP, REMOVE_STEP } from "../actions/step_actions";

// reducers/steps_reducer.js
const initialState = {
  1: { // this is the step with id = 1
    id: 1,
    title: "walk to store",
    done: "undone",
    todo_id: 1
  },
  2: { // this is the step with id = 2
    id: 2,
    title: "buy soap",
    done: "done",
    todo_id: 1
  }
};

const stepsReducer = (state = initialState, action) => {
  Object.freeze(state);
  let newState = merge({}, state);
  switch(action.type) {
    case RECEIVE_STEPS:
      newState = action.steps;
      return newState;
    case RECEIVE_STEP:
      newState[action.step.id] = action.step;
      return newState;
    case REMOVE_STEP:
      delete newState[action.step.id];
      return newState;
    default:
      return state;
  }
};

export default stepsReducer;
