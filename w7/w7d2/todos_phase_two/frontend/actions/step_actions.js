export const RECEIVE_STEPS = "RECEIVE_STEPS";
export const RECEIVE_STEP = "RECEIVE_STEP";
export const REMOVE_STEP = "REMOVE_STEP";
import { fetchStepsUtil, createStepUtil, updateStepUtil, deleteStepUtil } from '../util/step_api_util';
import { receiveErrors } from './error_actions';

export const fetchSteps = function() {
  return (dispatch) => {
    return fetchStepsUtil().then((response) => {
      let newState = {};
      for (let i = 0; i < response.length; i++) {
        newState[response[i].id] = response[i];
      }
      return dispatch(receiveSteps(newState));
    });
  };
};


// export const createStep = function(step) {
//   // console.log(step);
//   return (dispatch) => {
//     // console.log(createStepUtil(step));
//     return createStepUtil(step).then((response) => {
//       return dispatch(receiveStep(response));
//     });
//   };
// };
export function createStep(step) {
  return (dispatch) => {
    return createStepUtil(step)
      .then(response => dispatch(receiveStep(response)),
            err => dispatch(receiveErrors(err.responseJSON)));
  };
}

export function updateStep(step) {
  return (dispatch) => {
    return updateStepUtil(step)
      .then(response => dispatch(receiveStep(response)),
            err => dispatch(receiveErrors(err.responseJSON)));
  };
}

export function deleteStep(step) {
  return (dispatch) => {
    return deleteStepUtil(step)
      .then(response => {
              dispatch(removeStep(step));
            },
            err => dispatch(receiveErrors(err.responseJSON)));
  };
}

export const receiveSteps = function(steps) {
  return {
    type: RECEIVE_STEPS,
    steps: steps
  };
};

export const receiveStep = function(step) {
  return {
    type: RECEIVE_STEP,
    step: step
  };
};

export const removeStep = function(step) {
  return {
    type: REMOVE_STEP,
    step: step
  };
};
