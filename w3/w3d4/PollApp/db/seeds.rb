# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u1 = User.create(user_name: "Ken")
u2 = User.create(user_name: "Khalil")
u3 = User.create(user_name: "Jeff")

p1 = Poll.create(title: "Major poll", author_id: 2)

q1 = Question.create(poll_id: 1, text: "What is your age?")
q2 = Question.create(poll_id: 1, text: "Where are you from?")
q3 = Question.create(poll_id: 1, text: "What is your favorite color?")

a1 = AnswerChoice.create(question_id: 1, text: "20-29")
a2 = AnswerChoice.create(question_id: 1, text: "30-39")
a3 = AnswerChoice.create(question_id: 2, text: "USA")
a4 = AnswerChoice.create(question_id: 2, text: "Not USA")
a5 = AnswerChoice.create(question_id: 3, text: "Red")
a6 = AnswerChoice.create(question_id: 3, text: "Blue")

r1 = Response.create(user_id: 1, answer_choice_id: 1)
r2 = Response.create(user_id: 1, answer_choice_id: 3)
r3 = Response.create(user_id: 1, answer_choice_id: 5)
# r4 = Response.create(user_id: 2, answer_choice_id: 2)
# r5 = Response.create(user_id: 2, answer_choice_id: 4)
# r6 = Response.create(user_id: 2, answer_choice_id: 6)
r7 = Response.create(user_id: 3, answer_choice_id: 1)
r8 = Response.create(user_id: 3, answer_choice_id: 3)
r9 = Response.create(user_id: 3, answer_choice_id: 6)
