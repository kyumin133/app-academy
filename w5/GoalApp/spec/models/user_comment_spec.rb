# == Schema Information
#
# Table name: user_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  comment    :text             not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserComment, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:comment) }
  it { should validate_presence_of(:author_id) }
  it { should belong_to(:user) }
  it { should belong_to(:author).with_foreign_key(:author_id).class_name(:User) }
end
