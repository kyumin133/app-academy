export const RECEIVE_STEPS = "RECIEVE_STEPS";
export const RECEIVE_STEP = "RECIEVE_STEP";
export const REMOVE_STEP = "REMOVE_STEP";

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
