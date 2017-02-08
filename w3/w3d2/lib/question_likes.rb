require_relative 'questions_database'
require_relative 'users'
require_relative 'questions'
require_relative 'model_base'

class QuestionLike < ModelBase

  attr_accessor :id, :user_id, :question_id

  def self.likers_for_question_id(question_id)
    likes_data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT users.id, users.fname, users.lname
      FROM users
      JOIN question_likes ON users.id = question_likes.user_id
      WHERE question_likes.question_id = ?
    SQL

    return nil if likes_data.length == 0
    likes_data.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    num_likes_data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT COUNT(*) AS "likes_count"
      FROM users
      JOIN question_likes ON users.id = question_likes.user_id
      WHERE question_likes.question_id = ?
    SQL

    return 0 if num_likes_data.length == 0
    num_likes_data[0]['likes_count']
  end

  def self.liked_questions_for_user_id(user_id)
    questions_data = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT questions.id, questions.title, questions.body, questions.user_id
      FROM questions
      JOIN question_likes ON questions.id = question_likes.question_id
      WHERE question_likes.user_id = ?
    SQL

    return nil if questions_data.length == 0
    questions_data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_questions(n)
    questions_data = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT questions.id, questions.title, questions.body, questions.user_id, COUNT(*) AS 'liked_count'
      FROM questions
      JOIN question_likes ON questions.id = question_likes.question_id
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
