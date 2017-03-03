const DOMNodeCollection = require("./dom_node_collection");
var loadFunctions = [];

function $l(selector) {
  let match_arr = [];
  if ((typeof selector === "string") || (selector instanceof String)) {
    let matches = document.querySelectorAll(selector);
    for (let i = 0; i < matches.length; ++i) {
      match_arr.push(matches[i]);
    }
    return new DOMNodeCollection(match_arr);
  } else if (selector instanceof HTMLElement) {
    match_arr = [selector];
    return new DOMNodeCollection(match_arr);
  } else if (typeof selector === "function") {
    // console.log(selector);
    if(document.readyState === 'complete') {
      selector();
    } else {
      loadFunctions.push(selector);
    }
  }
}

$l.extend = function(...objects) {
  if (objects.length < 2) {
    return;
  }
  let firstObject = objects[0];

  for (let i = 1; i < objects.length; i++) {
    let keys = Object.keys(objects[i])
    for (let j = 0; j < keys.length; j++) {
      firstObject[keys[j]] = objects[i][keys[j]];
    }
  }
  return firstObject;
}

$l.ajax  = function(options) {
  if (options === undefined) {
    options = {};
  }
  let mergedOptions = {
    success: function (response) { return JSON.parse(response.responseText) },
    error: function (response) { console.log(response) },
    url: "http://google.com",
    type: "GET",
    data: {},
    contentType: "application/x-www-form-urlencoded; charset=UTF-8"
  };

  this.extend(mergedOptions, options);

  // console.log(mergedOptions);
  //step 1 - create xhr object
  const xhr = new XMLHttpRequest();

  // step 2 - specify path and verb
    // console.log(mergedOptions.type.toString);
    // console.log(mergedOptions.contentType);
  xhr.open(mergedOptions.type, mergedOptions.url, true);
  if ((mergedOptions.type === "POST") || (mergedOptions.type === "PUT")) {
    xhr.setRequestHeader("contentType", mergedOptions.contentType);
  }

  // step 3 - register a callback
  xhr.onreadystatechange = function () {
    if(xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
      mergedOptions.success(JSON.parse(xhr.responseText));
    }
  };


  xhr.addEventListener("error", mergedOptions.error);

  // console.log(xhr);
  xhr.send(mergedOptions.data);
  }

document.addEventListener("DOMContentLoaded", () => {
  window.$l = $l;

  for (let i = 0; i < loadFunctions.length; i++) {
    loadFunctions[i]();
  }

  $l.ajax({
    type: 'GET',
    url: "http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=bcb83c4b54aee8418983c2aff3073b3b",
    success(data) {
      console.log("We have your weather!")
      console.log(data);
    },
    error() {
      console.error("An error occurred.");
    },
  });
});
