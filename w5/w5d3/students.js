class Student {
  constructor(firstName, lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.courses = [];
  }

  name() {
    return `${this.firstName} ${this.lastName}`;
  }

  enroll(course) {
    if (this.courses.includes(course)) return;
    if (this.hasConflict(course)) throw "Time conflicts!";
    this.courses.push(course);
    course.enrolled_students.push(this)
  }

  hasConflict(course) {
    for (let i = 0; i < this.courses.length; i++) {
      if (this.courses[i].conflictsWith(course)) {
        return true;
      }
    }
    return false;
  }

  courseLoad() {
    let credits = {};
    for (let i = 0; i < this.courses.length; i++) {
      let course = this.courses[i];
      credits[course.department]
        ? credits[course.department] += course.credits
        : credits[course.department] = course.credits;
    }
    return credits;
  }

}

class Course {
  constructor(name, department, credits, time, days) {
    this.name = name;
    this.department = department;
    this.credits = credits;
    this.enrolled_students = [];
    this.time = time;
    this.days = days;
  }

  students() {
    return this.enrolled_students;
  }

  addStudent(student) {
    student.enroll(this);
  }

  conflictsWith(otherCourse) {
    if (this.time != otherCourse.time) {
      return false;
    }
    for (let i = 0; i < this.days.length; i++) {
      for (let j = 0; j < otherCourse.days.length; j++) {
        if (this.days[i] === otherCourse.days[j]) {
          return true;
        }
      }
    }
    return false;
  }

}
