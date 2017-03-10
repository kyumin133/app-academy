export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_SINGLE_POKEMON = "RECEIVE_SINGLE_POKEMON";
export const RECEIVE_NEW_POKEMON = "RECEIVE_NEW_POKEMON";
export const RECEIVE_POKEMON_ERRORS = "RECEIVE_POKEMON_ERRORS";
export const START_LOADING_ALL_POKEMON = "START_LOADING_ALL_POKEMON";
export const START_LOADING_ONE_POKEMON = "START_LOADING_ONE_POKEMON";
export const FINISH_LOADING = "FINISH_LOADING";
import { fetchAllPokemon, fetchSinglePokemon, createPokemon } from '../util/api_util.js';

export const receiveAllPokemon = (pokemon) => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receiveSinglePokemon = (pokemonDetail) => ({
  type: RECEIVE_SINGLE_POKEMON,
  pokemonDetail
});

export const receiveNewPokemon = (pokemon) => ({
  type: RECEIVE_NEW_POKEMON,
  pokemon
});

export const receivePokemonErrors = (errors) => ({
  type: RECEIVE_POKEMON_ERRORS,
  errors
});

export const startLoadingAllPokemon = () => ({
  type: START_LOADING_ALL_POKEMON
});

export const startLoadingOnePokemon = () => ({
  type: START_LOADING_ONE_POKEMON
});

export const finishLoading = () => ({
  type: FINISH_LOADING
});

export const requestAllPokemon = () => (dispatch) => {
  dispatch(startLoadingAllPokemon());
  return fetchAllPokemon()
    .then(pokemon => {
      dispatch(finishLoading());
      return dispatch(receiveAllPokemon(pokemon));
    });
};

export const requestSinglePokemon = (pokemonId) => (dispatch) => {
  dispatch(startLoadingOnePokemon());
  return fetchSinglePokemon(pokemonId)
    .then(pokemonDetail => {
      dispatch(finishLoading());
      return dispatch(receiveSinglePokemon(pokemonDetail));
    });
};

export const requestNewPokemon = (pokemon) => (dispatch) => {
  dispatch(startLoadingOnePokemon());
  return createPokemon(pokemon)
    .then(newPokemon => {
      // console.log("successful!!");
      dispatch(finishLoading());
      dispatch(receiveNewPokemon(newPokemon));
      return newPokemon;
    }, errors => {
      // console.log("error!!");
      // console.log(JSON.parse(errors.responseText));
      dispatch(finishLoading());
      return dispatch(receivePokemonErrors(JSON.parse(errors.responseText)));
    });
};
