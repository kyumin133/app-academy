# == Schema Information
#
# Table name: goal_comments
#
#  id         :integer          not null, primary key
#  goal_id    :integer          not null
#  comment    :text             not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GoalComment < ActiveRecord::Base
  validates :goal_id, :comment, :author_id, presence: true
  belongs_to :goal

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User
end
