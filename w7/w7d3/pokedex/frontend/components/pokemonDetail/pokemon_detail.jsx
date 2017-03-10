import React from 'react';
import Items from '../item/items';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestSinglePokemon(this.props.params.pokemonId);
  }

  componentWillReceiveProps(newProps) {
    if (newProps.params.pokemonId !== this.props.params.pokemonId) {
      this.props.requestSinglePokemon(newProps.params.pokemonId);
    }
  }

  render() {
    if (this.props.loading.one) {
      return  <div id="loading-pokeball-container">
                <div id="loading-pokeball"></div>
              </div>;
    }

    let pokePage = " ";
    let pokeItems =" ";
    let pokemonDetail = this.props.pokemonDetail;
    let itemDetailDiv = <div></div>;
    if(pokemonDetail.id!== undefined){
      pokeItems = <Items items={pokemonDetail.items}/>;
      pokePage = (
        <div className="pokemon-detail-stats">
         <div className="large-image-div">
           <img src={pokemonDetail.image_url} className ="large-image"/>
         </div>
         <h3 className="pokemon-name">{pokemonDetail.name}</h3>
         <ul className="pokemon-detail-list">
           <li>Type: {pokemonDetail.poke_type}</li>
           <li>Attack: {pokemonDetail.attack}</li>
           <li>Defense: {pokemonDetail.defense}</li>
           <li>Moves: {pokemonDetail.moves.join(", ")}</li>
         </ul>

        </div>);
        if(pokemonDetail.items.length > 0){
          itemDetailDiv = <div className="items-detail">
            <span>Items</span>
            {pokeItems}
            {this.props.children}
          </div>;
        }
    }

    return <div className="pokemon-detail">
              <div>
                {pokePage}
              </div>
                {itemDetailDiv}
          </div>;
  }
}

export default PokemonDetail;
