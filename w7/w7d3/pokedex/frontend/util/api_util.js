export const fetchAllPokemon = () => {
  return $.ajax({
    url: "api/pokemon",
    type: "GET"
  });
};

export const fetchSinglePokemon = (pokemonId) => {
  return $.ajax({
    url: `api/pokemon/${pokemonId}`,
    tpye: "GET"
  });
};
