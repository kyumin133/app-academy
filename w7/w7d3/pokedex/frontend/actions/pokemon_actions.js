export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_SINGLE_POKEMON = "RECEIVE_SINGLE_POKEMON";
import { fetchAllPokemon, fetchSinglePokemon } from '../util/api_util.js';

export const receiveAllPokemon = (pokemon) => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receiveSinglePokemon = (pokemonDetail) => ({
  type: RECEIVE_SINGLE_POKEMON,
  pokemonDetail
});

export const requestAllPokemon = () => (dispatch) => {
  return fetchAllPokemon()
    .then(pokemon => dispatch(receiveAllPokemon(pokemon)));
};

export const requestSinglePokemon = (pokemonId) => (dispatch) => {
  return fetchSinglePokemon(pokemonId)
    .then(pokemonDetail => dispatch(receiveSinglePokemon(pokemonDetail)));
};
