import React from 'react';
import ReactDOM from 'react-dom';
import Tabs from './tabs';
import Clock from './clock';
import Weather from './weather'
import AutoComplete from './autocomplete'

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("root");
  let data = [
    {
      title: "A",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
    {
      title: "B",
      content: "banana"
    }
  ]

  let names = ["Andy", "Ann", "April", "Ben", "Chris", "Donna", "Jerry", "Leslie", "Ron", "Tom"]
	ReactDOM.render(
    <div className="grid">
      <div className="col left-col">
        <Clock/>
        <Weather/>
      </div>
      <div className="col mid-col">
        <Tabs data={data}/>
      </div>
      <div className="col right-col">
        <AutoComplete names={names}/>
      </div>
    </div>, root);
});
