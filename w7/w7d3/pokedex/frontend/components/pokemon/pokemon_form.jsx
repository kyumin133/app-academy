import React from 'react';
import { withRouter } from 'react-router';

const TYPES = [
    "fire",
    "electric",
    "normal",
    "ghost",
    "psychic",
    "water",
    "bug",
    "dragon",
    "grass",
    "fighting",
    "ice",
    "flying",
    "poison",
    "ground",
    "rock",
    "steel"
  ].sort();

class PokemonForm extends React.Component{


  constructor(props){
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.errors = this.errors.bind(this);
    this.state = {
      pokemon: {
        name: "",
        attack: "",
        defense: "",
        poke_type: TYPES[0],
        moves: []
      },
      move1: "",
      move2: ""
    };
  }

  handleChange(e) {
    e.preventDefault();

    let id = e.target.id;
    if (id.slice(0, 4) === "move") {
      this.setState({
        [id]: e.target.value
      });
    } else {
      let pokemon = this.state.pokemon;
      pokemon[id] = e.target.value;
      this.setState({
        pokemon: pokemon
      });
    }
  }

  handleSubmit(e) {
    e.preventDefault();
    let moves = [];
    if (this.state.move1.length > 0) {
      moves = moves.concat(this.state.move1);
    }
    if (this.state.move2.length > 0) {
      moves = moves.concat(this.state.move2);
    }

    let pokemon = this.state.pokemon;
    pokemon.moves = moves;
    this.setState({
      pokemon: pokemon
    });
    this.props.requestNewPokemon(this.state.pokemon).then((response) => {

      if (response.errors === undefined) {
        this.props.router.push(`pokemon/${response.id}`);
      } else {
        this.forceUpdate();
      }
    });
  }

  errors() {
    if (Object.keys(this.props.errors).length === 0) {
      return null;
    }
    let errorsArr = this.props.errors.map((error, idx) => {
      return <li key={idx}>{error}</li>;
    });
    return <ul className="errors">{errorsArr}</ul>;
  }

  render(){
    // console.log(this.state);
    let selectType = TYPES.map((type,idx) => (
      <option key={idx} value={type}>{type}</option>
    ));

    return(
      <div className ="new-pokemon-div">
        <div className="new-pokemon-form">
          <img src="/assets/pokemon-logo.svg" className="logo"></img>
          {this.errors()}
          <form onChange={this.handleChange}>
            <input type="text" id="name" placeholder="Name"></input>
            <input type="text" id="image_url" placeholder="Image Url"></input>
            <select id="poke_type">
              {selectType}
            </select>
            <input type="number" id="attack" placeholder="Attack"></input>
            <input type="number" id="defense" placeholder="Defense"></input>
            <input type="text" id="move1" placeholder="Move 1"></input>
            <input type="text" id="move2" placeholder="Move 2"></input>
            <button type="button" onClick={this.handleSubmit}>Create Pokemon</button>
          </form>
        </div>
      </div>
    );
  }
}
export default withRouter(PokemonForm);
