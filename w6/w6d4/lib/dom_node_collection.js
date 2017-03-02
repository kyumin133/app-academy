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
