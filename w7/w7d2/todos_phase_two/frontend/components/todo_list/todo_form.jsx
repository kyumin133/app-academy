import React from 'react';
import { uniqueId } from '../../util/util';


class TodoForm extends React.Component {
  constructor(props) {
    super(props);

    this.props = props;
    this.state = {
      title: "",
      body: "",
      done: false
    };
    this.createTodo = this.createTodo.bind(this);
    this.changeTitle = this.changeTitle.bind(this);
    this.changeBody = this.changeBody.bind(this);
  }

  resetState() {
    this.setState({
      title: "",
      body: "",
      done: false
    });
    this.props.clearErrors();
  }
  createTodo(e) {
    e.preventDefault();

    this.props.createTodo(this.state).then(
      () => {
        this.resetState();
      }
    );
  }

  changeTitle(e) {
    this.setState({title: e.target.value});
  }

  changeBody(e) {
    this.setState({body: e.target.value});
  }

  render(){
    let error = "";
    let errorArr = this.props.error;
    if (errorArr.length > 0) {
      let errorUl = [];
      for (let i = 0; i < errorArr.length; i++) {
        errorUl.push(<li key={i}>{errorArr[i]}</li>);
      }
      error = <ul>{errorUl}</ul>;
    }

    let tags = "";
    let tagsArr = this.props.tags;
    console.log(tagsArr);

    let tagsUl = [];
    for (let tagId in tagsArr) {
      if (tagsArr.hasOwnProperty(tagId)) {
        tagsUl.push(<input type="checkbox" name="tag" value={tagId}>{tagsArr[tagId].tag}</input>);
      }
    }
    tags = <div>{tagsUl}</div>;

    return (
      <div>
        {error}
        <form>
          <input type="text" value={this.state.title} onChange={this.changeTitle} placeholder="Title"></input>
          <input type="text" value={this.state.body} onChange={this.changeBody} placeholder="Body"></input>
          {tags}
          <button onClick={this.createTodo}>Create</button>
        </form>
      </div>
    );
  }
}
export default TodoForm;

//     id: 3,
//     title: "sell car",
//     body: "with soap",
//     done: false
//   },
