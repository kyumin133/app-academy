import React from 'react';

class Weather extends React.Component {
  constructor(props) {
    super(props);
    let key = "a14f63321ffcb0242c59dfd7cffa7849";

    this.state = {
      ready: false,
    }
    navigator.geolocation.getCurrentPosition((position) => {
      // console.log(position);
      let request = new XMLHttpRequest();
      let url = "http://api.openweathermap.org/data/2.5/weather?";
      url = url.concat(`lat=${position.coords.latitude}&`);
      url = url.concat(`lon=${position.coords.longitude}&`);
      url = url.concat(`appid=${key}`);
      request.open('GET', url, true);

      request.onload = () => {
        if (request.status >= 200 && request.status < 400) {
          // Success!
          let resp = JSON.parse(request.responseText);

          let weather = {
            city: resp.name,
            temp: Math.floor(((parseInt(resp.main.temp) - 273.15) * (9/5) + 32) * 10) / 10
          };

          // console.log(weather);
          this.setState({ready: true, weather: weather})
        } else {
          // We reached our target server, but it returned an error
        }
      };

      request.onerror = function() {
        // There was a connection error of some sort
        console.log("connection error");
      };

      // let params = JSON.stringify({lat: position.coords.latitude, lon: position.coords.longitude, APPID: key})
      request.send();

    });
  }
  render () {
    let tbody = "";
    if (this.state.ready === true) {
      return <div className="weather">
                <h1>Weather</h1>
                <table>
                  <tbody>
                    <tr>
                      <th>
                        City:
                      </th>
                      <td>
                        {this.state.weather.city}
                      </td>
                    </tr>
                    <tr>
                      <th>
                        Temperature:
                      </th>
                      <td>
                        {this.state.weather.temp}&#xb0; F
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>;
    } else {
      return <div className="weather loading">
                <h1>Weather</h1>
                <table>
                  <tbody>
                    <tr>
                      <th>
                        Loading weather...
                      </th>
                    </tr>
                  </tbody>
                </table>
              </div>;
    }
  }
}

export default Weather;
