export const fetchAllPokemon = () => {
  return $.ajax({
    url: "api/pokemon",
    type: "GET"
  });
};

export const fetchSinglePokemon = (pokemonId) => {
  return $.ajax({
    url: `api/pokemon/${pokemonId}`,
    type: "GET"
  });
};

export const createPokemon = (pokemon) => {
  return $.ajax({
    url: "api/pokemon",
    type: "POST",
    data: { pokemon: pokemon },
    error: (error) => {
      return error;
    }
  });
};
