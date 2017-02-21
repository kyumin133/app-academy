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

require 'rails_helper'

RSpec.describe GoalComment, type: :model do
  it { should validate_presence_of(:goal_id) }
  it { should validate_presence_of(:comment) }
  it { should validate_presence_of(:author_id) }

  it { should belong_to(:goal) }
  it { should belong_to(:author).with_foreign_key(:author_id).class_name(:User) }
end
