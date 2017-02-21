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

FactoryGirl.define do
  factory :goal_comment do
    
  end
end
