import React from 'react';
import { Link } from 'react-router';


class PokemonIndexItem extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    let pokemon = this.props.pokemon;
    let pokemonUrl = `/pokemon/${pokemon.id}`;
    return  <li>
              <Link to={pokemonUrl}>
                <table>
                  <tbody>
                    <tr>
                      <td className="pokemon-id"><span>{pokemon.id}</span></td>
                      <td className="pokemon-img"><img className="small-image" src={pokemon.image_url}></img></td>
                      <td className="pokemon-name"><span>{pokemon.name}</span></td>
                    </tr>
                  </tbody>
                </table>
              </Link>
            </li>;
  }
}

export default PokemonIndexItem;
