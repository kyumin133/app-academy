export const RECEIVE_TAGS = "RECEIVE_TAGS";
export const RECEIVE_TAG = "RECEIVE_TAG";
export const REMOVE_TAG = "REMOVE_TAG";
import { fetchTagsUtil, createTagUtil, deleteTagUtil } from '../util/tag_api_util';
import { receiveErrors } from './error_actions';

export const fetchTags = function() {
  return (dispatch) => {
    return fetchTagsUtil().then((response) => {
      let newState = {};
      for (let i = 0; i < response.length; i++) {
        newState[response[i].id] = response[i];
      }
      return dispatch(receiveTags(newState));
    });
  };
};

export function createTag(tag) {
  return (dispatch) => {
    return createTagUtil(tag)
      .then(response => dispatch(receiveTag(response)),
            err => dispatch(receiveErrors(err.responseJSON)));
  };
}


export function deleteTag(tag) {
  return (dispatch) => {
    return deleteTagUtil(tag)
      .then(response => {
              dispatch(removeTag(tag));
            },
            err => dispatch(receiveErrors(err.responseJSON)));
  };
}

export const receiveTags = function(tags) {
  return {
    type: RECEIVE_TAGS,
    tags: tags
  };
};

export const receiveTag = function(tag) {
  return {
    type: RECEIVE_TAG,
    tag: tag
  };
};

export const removeTag = function(tag) {
  return {
    type: REMOVE_TAG,
    tag: tag
  };
};
