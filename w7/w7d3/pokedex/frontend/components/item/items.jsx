import React from "react";
import { Link } from 'react-router';

class Items extends React.Component {
  constructor(props) {
    super(props);
  }

  render () {
    let itemsArr = this.props.items.map((item) => {
      let item_url = `pokemon/${item.pokemon_id}/item/${item.id}`;
      return  <Link to={item_url} key={item.id}>
                <li>
                  {item.name}
                </li>
              </Link>;
    });
    return  <div>
              <ul>{itemsArr}</ul>              
            </div>;
  }
}

export default Items;
