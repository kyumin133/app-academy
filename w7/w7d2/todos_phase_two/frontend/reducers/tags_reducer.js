import merge from 'lodash/merge';
import { RECEIVE_TAGS, RECEIVE_TAG, REMOVE_TAG } from "../actions/tag_actions";

// reducers/tags_reducer.js
const initialState = {};

const tagsReducer = (state = initialState, action) => {
  Object.freeze(state);
  let newState = merge({}, state);
  switch(action.type) {
    case RECEIVE_TAGS:
      newState = action.tags;
      return newState;
    case RECEIVE_TAG:
      newState[action.tag.id] = action.tag;
      return newState;
    case REMOVE_TAG:
      delete newState[action.tag.id];
      return newState;
    default:
      return state;
  }
};

export default tagsReducer;
