import React from 'react';

class Clock extends React.Component {
  constructor(props) {
    super(props);

    let time = new Date();
    // console.log(time);
    this.state = {
      time: time
    }
  }

  componentDidMount() {
    this.interval = setInterval(() => {
      this.setState({time: new Date()});
    }, 1000);
  }

  componentWillUnmount() {
    clearInterval(this.interval)
  }

  render() {
    return  <div className="clock">
              <h1>Clock</h1>
              <table>
                <tbody>
                  <tr>
                    <th>
                      Date:
                    </th>
                    <td>
                      {this.state.time.toDateString()}
                    </td>
                  </tr>
                  <tr>
                    <th>
                      Time:
                    </th>
                    <td>
                      {this.state.time.toTimeString()}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>;
  }
}

export default Clock;
