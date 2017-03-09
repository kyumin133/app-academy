import values from "lodash/values";

export const selectAllPokemon = (state) => {
  return values(state.pokemon);
};

export const selectPokemonItem = (state, itemId) => {
  if (state.pokemonDetail.items === undefined) {
    return undefined;
  } else {
    let index = state.pokemonDetail.items.findIndex((item) => {
      return item.id.toString() === itemId;
    });

    return state.pokemonDetail.items[index];
  }
};
