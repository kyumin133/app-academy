import React from 'react';

class AutoComplete extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      allNames: props.names,
      names: props.names,
      // searchTerm: ""
    }
    this.search = this.search.bind(this)
    this.setSearch = this.setSearch.bind(this)
  }

  search(e) {
    let searchTerm = e.currentTarget.value;
    let names = [];
    for (let i = 0; i < this.state.allNames.length; i++) {
      if (this.state.allNames[i].toLowerCase().startsWith(searchTerm.toLowerCase())) {
        names.push(this.state.allNames[i]);
      }
    }
    this.setState({names: names});
  }

  setSearch(e) {
    console.log(e.currentTarget.innerHTML);
    this.setState({names: [e.currentTarget.innerHTML]});
  }

  render () {
    let names = [];
    for (let i = 0; i < this.state.names.length; i++) {
      names.push(<li className="name" key={i} onClick={this.setSearch}>{this.state.names[i]}</li>);
    }
    console.log(this.state.names);
    return  <section className="auto-complete">
              <h1>Auto Complete</h1>
              <form>
                <input type="text" placeholder="Search..." onChange={this.search} name="search" value={this.state.searchTerm}/>
                <ul>
                  {names}
                </ul>
              </form>
            </section>;
  }
}

export default AutoComplete;
