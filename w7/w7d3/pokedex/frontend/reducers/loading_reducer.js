import { START_LOADING_ALL_POKEMON, START_LOADING_ONE_POKEMON, FINISH_LOADING } from '../actions/pokemon_actions';
import merge from 'lodash/merge';

const loadingReducer = (state = {}, action) => {
  Object.freeze(state);
  switch (action.type) {
    case START_LOADING_ALL_POKEMON:
      return {
        all: true
      };
    case START_LOADING_ONE_POKEMON:
      return {
        one: true
      };
    case FINISH_LOADING:
      return {
        all: false,
        one: false
      };
    default:
      return false;
  }
};



export default loadingReducer;
