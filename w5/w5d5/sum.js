function sum_arguments(nums) {
  let total = 0;
  for (let i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}

function sum_spread(...args) {
  let total = 0;
  for (let i = 0; i < args.length; i++) {
    total += args[i];
  }
  return total;
}


console.log(sum_arguments(1, 2, 3, 4));
console.log(sum_arguments(1, 2, 3, 4, 5));

console.log(sum_spread(1, 2, 3, 4));
console.log(sum_spread(1, 2, 3, 4, 5));
