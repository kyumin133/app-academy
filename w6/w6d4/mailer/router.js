function Router(node, routes) {
  this.node = node;
  this.routes = routes;
}

Router.prototype.start = function() {
  window.addEventListener("hashchange", () => {
    this.render();
  });
}

Router.prototype.render = function() {
  this.node.innerHTML = "";
  let component = this.activeRoute();
  if (component === undefined) {
  } else {
    this.node.appendChild(component.render());
  }
}

Router.prototype.activeRoute = function() {
  let fragment = window.location.hash;
  return this.routes[fragment.slice(1)];
}

module.exports = Router;
