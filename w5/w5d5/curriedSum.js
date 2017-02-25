function curriedSum(numArgs) {
  let numbers = [];
  return function _curriedSum(num) {
    numbers.push(num);
    // console.log(numbers);
    if (numbers.length === numArgs) {
      let sum = 0;
      for (let i = 0; i < numbers.length; i++) {
        sum += numbers[i];
      }
      return sum;
    } else {
      return function (nextNum) {
        return _curriedSum(nextNum);
      }
    }
  }
}

Function.prototype.curry = function (numArgs) {
  let args = [];
  let func = this;
  return function _curry(...currArgs) {
    args = args.concat(currArgs);
    if (args.length === numArgs) {
      console.log(args);
      return func(args);
    } else {
      return function (...nextArgs) {
        return _curry(...nextArgs);
      }
    }
  }
}

const sum = curriedSum(4);
console.log(sum(5)(30)(20)(1));

let f = function(arr) {
  let total = 0;
  console.log(`Arguments: ${arr}`);
  for (let i = 0; i < arr.length; i++ ) {
    console.log(`${arr[i]}`);
    total += arr[i];
  }
  console.log(`Total: ${total}`);
}

let c = f.curry(4);
c(1)(2)(3, 4);
