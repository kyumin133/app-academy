import {connect} from 'react-redux';
import {requestSinglePokemon} from '../../actions/pokemon_actions';
import PokemonDetail from './pokemon_detail';

const mapStateToProps = state => {
  return{
  pokemonDetail: state.pokemonDetail
};};

const mapDispatchToProps = dispatch => {
  return {
    requestSinglePokemon: (pokemonId) => {
      return dispatch(requestSinglePokemon(pokemonId));
    }
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(PokemonDetail);
