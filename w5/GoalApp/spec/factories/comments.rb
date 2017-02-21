# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  comment          :text             not null
#  author_id        :integer          not null
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :comment do
    
  end
end
