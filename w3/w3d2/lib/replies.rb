require_relative 'questions_database'
require_relative 'users'
require_relative 'questions'
require_relative 'model_base'

class Reply < ModelBase

  attr_accessor :id, :body, :user_id, :parent_reply_id, :question_id

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @user_id = options['user_id']
  end

  def author
    raise "#{self} not in database" unless @id
    data = QuestionDBConnection.instance.execute("SELECT * FROM users WHERE id = #{@user_id}")
    User.new(data[0])
  end

  def question
    raise "#{self} not in database" unless @id
    data = QuestionDBConnection.instance.execute("SELECT * FROM questions WHERE id = #{@question_id}")
    Question.new(data[0])
  end

  def parent_reply
    raise "#{self} not in database" unless @id
    raise "#{self} has no parents" unless @parent_reply_id
    data = QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE id = #{@parent_reply_id}")
    Reply.new(data[0])
  end

  def child_replies
    raise "#{self} not in database" unless @id
    data = QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE parent_reply_id = #{@id}")
    return nil if data.length == 0
    data.map { |datum| Reply.new(datum) }
  end

end
