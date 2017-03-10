import {connect} from 'react-redux';
import {requestNewPokemon} from '../../actions/pokemon_actions';
import PokemonForm from './pokemon_form';

const mapStateToProps = state => {
  return {
    errors: state.errors
  };
};
const mapDispatchToProps = dispatch => {
  return {
    requestNewPokemon: (pokemon) => {
      return dispatch(requestNewPokemon(pokemon));
    }
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(PokemonForm);
