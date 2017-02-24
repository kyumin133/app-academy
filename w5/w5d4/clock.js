class Clock {
  constructor() {
    // 1. Create a Date object.
    // 2. Store the hours, minutes, and seconds.
    // 3. Call printTime.
    // 4. Schedule the tick at 1 second intervals.
    let date = new Date();
    this.hours = date.getHours();
    console.log(this.hours);
    this.minutes = date.getMinutes();
    this.seconds = date.getSeconds();
    this.printTime();
    setInterval(this._tick.bind(this), 1000);
  }

  printTime() {
    // Format the time in HH:MM:SS
    // Use console.log to print it.
    let hoursStr = this.hours.toString();
    let minutesStr = this.minutes.toString();
    let secondsStr = this.seconds.toString();

    if (this.hours < 10) {
      hoursStr = "0".concat(hoursStr);
    }
    if (this.minutes < 10) {
      minutesStr = "0".concat(minutesStr);
    }
    if (this.seconds < 10) {
      secondsStr = "0".concat(secondsStr);
    }
    console.log(`${hoursStr}:${minutesStr}:${secondsStr}`)
  }

  _tick() {
    // 1. Increment the time by one second.
    // 2. Call printTime.
    this.seconds += 1;
    if (this.seconds >= 60) {
      this.seconds -= 60;
      this.minutes++;
    }
    if (this.minutes >= 60) {
      this.minutes -= 60;
      this.hours++;
    }
    if (this.hours >= 24) {
      this.hours -= 24;
    }
    this.printTime();
  }
}

const clock = new Clock();
