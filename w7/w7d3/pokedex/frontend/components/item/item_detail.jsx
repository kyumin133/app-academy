import React from 'react';

class ItemDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    let item = this.props.item;

    if (item !== undefined) {
      return  <div>
                <ul className = "item-detail-list">
                  <li>{item.name}</li>
                  <li>Happiness: {item.happiness}</li>
                  <li>Price: ${item.price}</li>
                </ul>
              </div>;
    } else {
      return null;
    }
  }
}

export default ItemDetail;
