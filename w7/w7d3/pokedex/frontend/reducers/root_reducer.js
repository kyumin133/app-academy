import pokemonReducer from './pokemon_reducer';
import pokemonDetailReducer from './pokemon_detail_reducer';
import errorsReducer from './errors_reducer';
import loadingReducer from './loading_reducer';
import {combineReducers} from 'redux';

const rootReducer = combineReducers({
  pokemon: pokemonReducer,
  pokemonDetail: pokemonDetailReducer,
  errors: errorsReducer,
  loading: loadingReducer
});

export default rootReducer;
