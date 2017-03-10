import React from 'react';
import PokemonIndexItem from './pokemon_index_item';

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    let pokemonArr = this.props.pokemon.map((pokemon) => {
      if(pokemon.id === undefined) return null;
      return  <PokemonIndexItem key={pokemon.id} pokemon={pokemon}/>;
    });


    if (this.props.loading.all) {
      return  <div id="loading-pokeball-container">
                <div id="loading-pokeball"></div>
              </div>;
    }

    return  <div className="pokemon-display">
              <div className="pokemon-index">
                <ul>{pokemonArr}</ul>
              </div>
              {this.props.children}
            </div>;
  }
}

export default PokemonIndex;
