const Util = {
  inherits (childClass, parentClass) {
    childClass.prototype = Object.create(parentClass.prototype);
    childClass.prototype.constructor = childClass;
  },

  randomVec (length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },
  // Scale the length of a vector by the given amount.
  scale (vec, m) {
    return [vec[0] * m, vec[1] * m];
  },

  distanceBetween (pos1, pos2) {
    let dx = pos1[0] - pos2[0];
    let dy = pos1[1] - pos2[1];
    return Math.sqrt((dx * dx) + (dy * dy));
  }

};

module.exports = Util;
