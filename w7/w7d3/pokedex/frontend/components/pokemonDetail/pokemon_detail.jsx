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

    let pokePage = " ";
    let pokemonDetail = this.props.pokemonDetail;
    if(pokemonDetail.id!== undefined){
      pokePage = (
        <div className="pokemon-detail-stats">
         <div className="large-image-div">
           <img src={pokemonDetail.image_url} className ="large-image"/>
         </div>
         <h3 className="pokemon-name">{pokemonDetail.name}</h3>
         <ul className="pokemon-details">
           <li>Type: {pokemonDetail.poke_type}</li>
           <li>Attack: {pokemonDetail.attack}</li>
           <li>Defense: {pokemonDetail.defense}</li>
           <li>Moves: {pokemonDetail.moves.join(", ")}</li>
         </ul>
         <Items items={pokemonDetail.items}/>
        </div>);

    }

    return <div className="pokemon-detail">
              <div>
                {pokePage}
              </div>
              <div>
                {this.props.children}
              </div>
          </div>;
  }
}

export default PokemonDetail;
