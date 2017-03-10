import {connect} from 'react-redux';
import {requestAllPokemon} from '../../actions/pokemon_actions';
import {selectAllPokemon} from '../../reducers/selectors';
import PokemonIndex from './pokemon_index';

const mapStateToProps = state => ({
  pokemon: selectAllPokemon(state),
  loading: state.loading
});

const mapDispatchToProps = dispatch => {
  return {
    requestAllPokemon: () => {
      // console.log("inside container");
      return dispatch(requestAllPokemon());
    }
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(PokemonIndex);
