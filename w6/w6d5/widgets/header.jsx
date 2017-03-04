import React from 'react';

class Header extends React.Component {
  constructor(props) {
    super(props);
    // console.log(props);
    this.state = {
      title: props.title,
    }

  }


  render() {
    return <h2>{this.state.title}</h2>;
  }
}

export default Header;
