Function.prototype.myBindArguments = function() {
  let context = arguments[0];
  let args = Array.prototype.slice.call(arguments, 1);
  let func = this;
  // func.apply(context, args);
  return function () {
    func.apply(context, args.concat(Array.prototype.slice.call(arguments)));
  };
}

Function.prototype.myBindRest = function(context, ...bindArgs) {
  let func = this;
  // func.apply(context, args);
  return function (...callArgs) {
    func.apply(context, bindArgs.concat(callArgs));
  };
}

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

markov.says("meow", "Ned");
// Markov says meow to Ned!
// true

// bind time args are "meow" and "Kush", no call time args
markov.says.myBindArguments(breakfast, "meow", "Kush")();
// Breakfast says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "me"
markov.says.myBindArguments(breakfast)("meow", "a tree");
// Breakfast says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
markov.says.myBindArguments(breakfast, "meow")("Markov");
// Breakfast says meow to Markov!
// true

// no bind time args (other than context), call time args are "meow" and "me"
const notMarkovSays = markov.says.myBindArguments(breakfast);
notMarkovSays("meow", "me");
// Breakfast says meow to me!
// true

markov.says.myBindRest(breakfast, "meow", "Kush")();
// Breakfast says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "me"
markov.says.myBindRest(breakfast)("meow", "a tree");
// Breakfast says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
markov.says.myBindRest(breakfast, "meow")("Markov");
// Breakfast says meow to Markov!
// true

// no bind time args (other than context), call time args are "meow" and "me"
const notMarkovSays2 = markov.says.myBindRest(breakfast);
notMarkovSays2("meow", "me");
