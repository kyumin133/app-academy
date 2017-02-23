Array.prototype.uniq = function() {
  let uniqueArr = [];
  for (let i = 0; i < this.length; i++) {
    let el = this[i];
    if (!uniqueArr.includes(el)) uniqueArr.push(el);
  }
  return uniqueArr;
};

Array.prototype.twoSum = function() {
  let pairs = [];
  for (let i = 0; i < this.length - 1; i++) {
    for (let j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) pairs.push([i, j]);
    }
  }
  return pairs;
}

Array.prototype.transpose = function() {
  const numRows = this.length,
        numCols = this[0].length;
  let transposed = [];

  for (let i = 0; i < numCols; i++) {
    let transposed_row = [];
    for (let j = 0; j < numRows; j++) {
      transposed_row.push(this[j][i]);
    }
    transposed.push(transposed_row);
  }
  return transposed;
}

Array.prototype.myEach = function(func) {
  for (let i = 0; i < this.length; i++) {
    func(this[i]);
  }
}

Array.prototype.myMap = function(func) {
  let mapped = [];
  this.myEach(el => mapped.push(func(el)));
  return mapped;
}

Array.prototype.myInject = function(func) {
  let accumulator = this[0];
  this.slice(1).myEach(el => accumulator = func(accumulator, el));
  return accumulator;
}

Array.prototype.bubbleSort = function() {
  for (let i = 0; i < this.length - 1; i++) {
    for (let j = 1; j < this.length - i; j++) {
      if (this[j - 1] > this[j]) {
        this.swap(j-1, j);
      }
    }
  }
  return this;
}

Array.prototype.swap = function(i, j) {
  let temp = this[i];
  this[i] = this[j];
  this[j] = temp;
}

String.prototype.substrings = function() {
  let substrings = [];
  for (let i = 0; i < this.length; i++) {
    for (let j = i; j < this.length; j++) {
      substrings.push(this.slice(i, j + 1));
    }
  }
  return substrings.uniq();
}

function range(start, end) {
  if (end < start) return [];
  return [start].concat(range(start + 1, end));
}

function exp(b, n) {
  if (n === 0) return 1;
  if (n === 1) return b;
  return b * exp(b, n-1);
}

function fibonacci(n) {
  if (n <= 0) return [];
  if (n <= 2) return [0, 1].slice(0, n);
  let prev_arr = fibonacci(n - 1);
  let last_elem = prev_arr[prev_arr.length - 2] + prev_arr[prev_arr.length - 1];
  return prev_arr.concat([last_elem]);
}

Array.prototype.bsearch = function(target) {
  if (this.length === 0) return null;
  let mid_index = Math.floor(this.length / 2);
  let mid_val = this[mid_index];

  if (target === mid_val) return mid_index;

  if (target < mid_val) {
    return this.slice(0, mid_index).bsearch(target);
  } else {
    let res = this.slice(mid_index + 1, this.length).bsearch(target);
    return (res === null) ? null : 1 + mid_index + res;
  }
}

function makeChange(amt, coins) {
  if (Math.min(...coins) > amt) return [];
  let change_combos = [];

  for (let i = 0; i < coins.length; i++) {
    let combo = [];
    let lesser_coins = coins.filter(coin => (coin <= amt) && (coin <= coins[i]));
    let max_coin = Math.max(...lesser_coins);
    combo = [max_coin].concat(makeChange(amt - max_coin, lesser_coins));
    change_combos.push(combo);
  }

  return change_combos.sort(function(a, b) {
    return (a.length >= b.length) ? 1 : -1;
  })[0];
}

Array.prototype.mergeSort = function() {
  if (this.length < 2) return this;
  let mid_index = Math.floor(this.length / 2);
  let left = this.slice(0, mid_index).mergeSort();
  let right = this.slice(mid_index, this.length).mergeSort();

  return merge(left, right);
}

function merge(left, right) {
  let merged = [];
  while(left.length > 0 && right.length > 0) {
    (left[0] < right[0]) ? merged.push(left.shift()) : merged.push(right.shift());
  }
  return merged.concat(left).concat(right);
}

// Array.prototype.subsets = function() {
//   if (this.length === 0) return [[]];
//
//   let first_el = this[0];
//   let subs = this.slice(1).subsets();
//   let total_subsets = [];
//
//   for (let i = 0; i < subs.length) {
//     let sub = subs[i]
//     for (let j = 0; j <= sub.length; j++) {
//       total_subsets.push(sub.slice(0, j + 1).concat([first_el].concat(sub.slice(j + 1, sub.length))));
//     }
//   }
// }

Array.prototype.subsets = function() {
  if (this.length === 0) return [[]];
  // if (this.length === 1) return [[], this];

  // let first_el = this[0];
  // let array_without_first = this.slice(1);
  // let subs_without_first = array_without_first.subsets();
  //
  // let total_subs = subs_without_first;
  // let subs_with_first = [[]];
  //
  // for (let i = 0; i < subs_without_first.length; i++) {
  //   subs_with_first.push([first_el].concat(subs_without_first[i]));
  //   console.log([first_el].concat(subs_without_first[i]));
  // }
  // console.log(subs_with_first)
  // console.log(subs_without_first)
  // total_subs.concat(subs_with_first)
  // return total_subs;

  //
  // for (let i = 0; i < subs.length; i++) {
  //   // let sub = subs[i];
  //   total_subsets = total_subsets.concat(subs.map(s => s.concat([first_el])));
  //   console.log(total_subsets);
  // }

  // return total_subsets;

  let first_el = this[0];
  let subs = this.slice(1).subsets();
  let total_subsets = [[]];

  for (let i = 0; i < subs.length; i++) {
    let sub = subs[i];
    let sub_with_first = sub.concat(first_el);
    total_subsets = total_subsets.concat_without_duplicate(sub_with_first.sort());
    total_subsets = total_subsets.concat_without_duplicate(sub.sort());
  }

  // let uniq =

  return total_subsets.uniq();
}

Array.prototype.concat_without_duplicate = function(otherArr) {
  for (let i = 0; i < this.length; i++) {
    if (otherArr.length !== this[i].length) {
      continue;
    }
    let is_dup = true;
    for (let j = 0; j < otherArr.length; j++) {
      if (otherArr[j] !== this[i][j]) {
        is_dup = false;
        break;
      }
    }
    if (is_dup) {
      return this;
    }
  }
  return this.concat([otherArr]);
}

class Cat {
  constructor(name, owner) {
    this.name = name;
    this.owner = owner;
  }

  // cuteStatement() {
  //   return `${this.owner} loves ${this.name}.`
  // }

  cuteStatement() {
    return `Everyone loves ${this.name}!`
  }

  meow() {
    return "Meow!"
  }

}
