/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.l = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };

/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};

/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};

/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);
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


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(els) {
    this.els = els;
    this.listeners = {};
    return this;
  }

  html(html) {
    if (html === undefined) {
      return this.els[0].innerHTML;
    } else {
      for (let i = 0; i < this.els.length; i++) {
        this.els[i].innerHTML = html;
      }
    }
  }

  empty() {
    for (let i = 0; i < this.els.length; i++) {
      this.els[i].innerHTML = "";
    }
  }

  append(element) {
    for (let i = 0; i < this.els.length; i++) {
      if (element.outerHTML === undefined) {
        if (element.html === undefined) {
          this.els[i].innerHTML = this.els[i].innerHTML.concat(element);
        } else {
          this.els[i].innerHTML = this.els[i].innerHTML.concat(element.html());
        }
      } else {
        this.els[i].innerHTML += element.outerHTML;
      }
    }
  }

  attr(attr, value) {
    if (value === undefined) {
      return this.els[0].getAttribute(attr);
    } else {
      for (let i = 0; i < this.els.length; i++) {
        this.els[i].setAttribute(attr, value);
      }
    }
  }

  addClass(className) {
    for (let i = 0; i < this.els.length; i++) {
      let oldName = this.els[i].className;
      let newName = oldName.concat(` ${className}`);
      this.els[i].className = newName;
    }
  }

  removeClass(className) {
    let regex = "[ ]*".concat(className).concat("[ ]*")

    for (let i = 0; i < this.els.length; i++) {
      let oldName = this.els[i].className;
      let newName = oldName.replace(new RegExp(regex, 'g'), "")
      this.els[i].className = newName;
    }
  }

  children() {
    let children = [];
    for (let i = 0; i < this.els.length; i++) {
      children = children.concat(this.els[i].children);
    }
    return new DOMNodeCollection(children);
  }

  parent() {
    let parents = [];
    for (let i = 0; i < this.els.length; i++) {
      console.log(this.els[i].parentNode);
      parents = parents.concat(this.els[i].parentNode);
    }
    return new DOMNodeCollection(parents);
  }

  find(selector) {
    let matches = []
    for (let i = 0; i < this.els.length; i++) {
      let queryMatches = this.els[i].querySelectorAll(selector);
      let queryMatchesArr = [];
      for (let j = 0; j < queryMatches.length; j++) {
        queryMatchesArr.push(queryMatches[j]);
      }
      matches = matches.concat(queryMatchesArr);
    }
    return new DOMNodeCollection(matches);
  }

  remove() {
    this.empty();

    this.els = [];
  }

  on(e, func) {
    if (this.listeners[e] === undefined) {
      this.listeners[e] = [func];
    } else {
      this.listeners[e].push(func);
    }
    for (let i = 0; i < this.els.length; i++) {
      this.els[i].addEventListener(e, func);
    }
  }

  off(e) {
    let listeners = this.listeners[e];
    for (let i = 0; i < this.els.length; i++) {
      for (let j = 0; j < this.els.length; j++)  {
        this.els[i].removeEventListener(e, listeners[j]);
      }
      this.listeners[e] = [];
    }
  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);