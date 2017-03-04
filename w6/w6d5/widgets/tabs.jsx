import React from 'react';
import Header from './header';

class Tabs extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      index: 0,
      data: props.data
    }

    this.setIndex = this.setIndex.bind(this);
  }

  setIndex(index) {
    this.setState({index: index});
    // this.render();s
  }

  render() {
    let rows = [];
    for(let i = 0; i < this.state.data.length; i++) {
      let className = "tab";
      if (i === this.state.index ) {
        className = className.concat(" selected");
      }
      rows.push(<li className={className} key={i.toString()} onClick={() => {this.setIndex(i)}}><Header title={this.state.data[i].title} /></li>);
    }
    let content = this.state.data[this.state.index].content;
    return (
      <div className="tabs">
        <h1>Tabs</h1>
        <ul>
          {rows}
        </ul>
        <article>
          {content}
        </article>
      </div>
    );
  }
}

export default Tabs;
