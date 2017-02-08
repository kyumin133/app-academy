require_relative 'questions_database'
require_relative 'users'
require_relative 'questions'
require_relative 'model_base'

class QuestionFollow < ModelBase

  attr_accessor :id, :user_id, :question_id

  def self.followers_for_question_id(question_id)
    users_data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT users.id, users.fname, users.lname
      FROM users
      JOIN questions ON users.id = questions.user_id
      WHERE questions.id = ?
    SQL

    return nil if users_data.length == 0
    users_data.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions_data = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT questions.id, questions.title, questions.body, questions.user_id
      FROM questions
      JOIN users ON users.id = questions.user_id
      WHERE users.id = ?
    SQL

    return nil if questions_data.length == 0
    questions_data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
    questions_data = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT questions.id, questions.title, questions.body, questions.user_id, COUNT(*) AS 'followers_count'
      FROM questions
      JOIN question_follows ON questions.id = question_follows.question_id
      GROUP BY questions.id
      ORDER BY COUNT(*) DESC
      LIMIT ?
    SQL

    return nil if questions_data.length == 0
    questions_data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

end
