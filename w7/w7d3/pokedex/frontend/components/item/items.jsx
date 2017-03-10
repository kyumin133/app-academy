import React from "react";
import { Link } from 'react-router';

class Items extends React.Component {
  constructor(props) {
    super(props);
  }

  render () {
    let itemsArr = this.props.items.map((item) => {
      let item_url = `pokemon/${item.pokemon_id}/item/${item.id}`;
      // console.log(item);
      return  <Link to={item_url} key={item.id}>
                <li>
                  <img src={item.image_url} className="item-image"/>
                </li>
              </Link>;
    });
    return  <div>
              <ul className="items-list">{itemsArr}</ul>
            </div>;
  }
}

export default Items;
