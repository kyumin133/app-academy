Function.prototype.inheritsSurrogate = function(SuperClass) {
  function Surrogate () {}
  Surrogate.prototype = SuperClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
}

Function.prototype.inheritsObject = function(SuperClass) {
  this.prototype = Object.create(SuperClass.prototype);
  this.prototype.constructor = this;
}


function MovingObject () {
  this.name = "moving object"
}

MovingObject.prototype.greet = function() {
  console.log(`This is a ${this.name}.`);
}

function Ship () {
  this.name = "ship";
}

Ship.inheritsObject(MovingObject);

function Asteroid () {
  this.name = "asteroid"
}
Asteroid.inheritsObject(MovingObject);

let m = new MovingObject();
m.greet();

let s = new Ship();
s.greet();

let a = new Asteroid();
a.greet();
