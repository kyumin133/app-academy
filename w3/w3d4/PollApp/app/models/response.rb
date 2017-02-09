# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :check_already_answered, :check_author

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def check_already_answered
    if respondent_already_answered?
      self.errors[:user] << "already answered question!"
    end
  end

  def check_author
    result = Poll.find_by_sql([ "
      SELECT polls.*
      FROM answer_choices
      JOIN questions ON questions.id = answer_choices.question_id
      JOIN polls ON polls.id = questions.poll_id
      WHERE answer_choices.id = ?", self.answer_choice_id ])

      author_id = result.first.author_id


      if author_id == self.user_id
        self.errors[:author] << "can't respond to their own poll."
      end
  end
end
