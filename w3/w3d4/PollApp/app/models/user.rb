# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  def completed_polls

    polls = Poll.find_by_sql (
      [ "
        SELECT polls.*, COUNT(user_responses.id) AS num_responses, COUNT(DISTINCT questions.id) AS num_questions
        FROM polls
        JOIN questions ON polls.id = questions.poll_id
        JOIN answer_choices ON questions.id = answer_choices.question_id
        LEFT OUTER JOIN
          (
            SELECT responses.id, responses.answer_choice_id
            FROM responses
            WHERE responses.user_id = ?
          ) user_responses ON user_responses.answer_choice_id = answer_choices.id
        GROUP BY polls.id
        HAVING COUNT(user_responses.id) = COUNT(DISTINCT questions.id)",
        self.id
      ]
    )
  end

  def uncompleted_polls
    uncompleted_polls = Poll.find_by_sql (
      [ "
        SELECT polls.*, COUNT(user_responses.id) AS num_responses, COUNT(DISTINCT questions.id) AS num_questions
        FROM polls
        JOIN questions ON polls.id = questions.poll_id
        JOIN answer_choices ON questions.id = answer_choices.question_id
        LEFT OUTER JOIN
          (
            SELECT responses.id, responses.answer_choice_id
            FROM responses
            WHERE responses.user_id = ?
          ) user_responses ON user_responses.answer_choice_id = answer_choices.id
        GROUP BY polls.id
        HAVING COUNT(user_responses.id) < COUNT(DISTINCT questions.id)",
        self.id
      ]
    )
  end
end
