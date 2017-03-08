# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

todos = Todo.create([{ title: "test 1", body: "test 1"}, { title: "test 2", body: "test 2"}, { title: "test 3", body: "test 3"}])

steps = Step.create([{ title: "1", body: "1", todo_id: 1}, { title: "2", body: "2", todo_id: 1}, { title: "3", body: "3", todo_id: 1}])
