require_relative 'questions_database'
require_relative 'questions'
require_relative 'replies'
require_relative 'question_follows'
require_relative 'question_likes'
require_relative "model_base"

class User < ModelBase

  attr_accessor :id, :fname, :lname

  def self.find_by_name(fname, lname)
    users_data = QuestionDBConnection.instance.execute("SELECT * FROM users WHERE fname = '#{fname}' AND lname = '#{lname}'")
    return nil if users_data.length == 0
    users_data.map { |user| User.new(user) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_user_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    data = QuestionDBConnection.instance.execute(<<-SQL, @id)
      SELECT (CAST(COUNT(DISTINCT question_likes.id) AS FLOAT) / COUNT(DISTINCT questions.id)) AS 'avg'
      FROM questions
      JOIN users ON users.id = questions.user_id
      LEFT OUTER JOIN question_likes ON questions.id = question_likes.question_id
      WHERE users.id = ?
    SQL

    return 0.0 if data[0]['avg'].nil?
    data[0]['avg']
  end

end
