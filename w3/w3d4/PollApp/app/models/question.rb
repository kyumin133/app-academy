# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  has_many :responses,
    through: :answer_choices,
    source: :choice_responses

  def bad_results
    results_hash = Hash.new(0)
    self.answer_choices.each do |choice|
      results_hash[choice.text] += choice.choice_responses.length
    end

    results_hash
  end

  def better_results # ask TA if this is making two queries
    results_hash = Hash.new(0)
    answer_choice_relation = self.answer_choices.includes(:choice_responses)
    answer_choice_relation.each do |choice|
      results_hash[choice.text] += choice.choice_responses.length
    end
    results_hash
  end

  def best_results
    results = AnswerChoice.select("answer_choices.*, COUNT(responses.id) as num_responses").
      joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id").
      group(:id).
      where(question_id: self.id)

    results_hash = Hash.new

    results.each do |el|
      el.num_responses ||= 0
      results_hash[el.text] = el.num_responses
    end

    results_hash
  end
end
