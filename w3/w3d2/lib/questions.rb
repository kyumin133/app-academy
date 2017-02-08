require_relative 'questions_database'
require_relative 'users'
require_relative 'replies'
require_relative 'question_follows'
require_relative 'question_likes'
require_relative 'model_base'

class Question < ModelBase

  attr_accessor :id, :title, :body, :user_id

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    raise "#{self} not in database" unless @id
    data = QuestionDBConnection.instance.execute("SELECT * FROM users WHERE id = #{@user_id}")
    User.new(data[0])
  end

  def replies
    raise "#{self} not in database" unless @id
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

end
