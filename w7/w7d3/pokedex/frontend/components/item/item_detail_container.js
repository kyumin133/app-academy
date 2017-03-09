import {connect} from 'react-redux';
import {selectPokemonItem} from '../../reducers/selectors';
// import {requestSinglePokemon, receiveSinglePokemon} from '../../actions/pokemon_actions';
import ItemDetail from './item_detail';

const mapStateToProps = (state, ownProps) => {
  return {
    item: selectPokemonItem(state, ownProps.params.itemId)
  };
};

const mapDispatchToProps = dispatch => {

};

export default connect(mapStateToProps, null)(ItemDetail);
