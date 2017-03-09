import React from 'react';

class ItemDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    let item = this.props.item;

    if (item !== undefined) {
      return  <div>
                <ul>
                  <li>{item.name}</li>
                  <li>{item.happiness}</li>
                  <li>{item.price}</li>
                </ul>
              </div>;
    } else {
      return null;
    }
  }
}

export default ItemDetail;
