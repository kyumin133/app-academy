# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  cheers          :integer          default("12"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    FactoryGirl.build(:user,
      username: "jonathan",
      password: "good_password",
      cheers: 12)
  end

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:cheers) }

  it { should have_many(:comments) }
  it { should have_many(:goals) }

  it "::find_by_credentials" do
    new_user = User.create(username: "samantha", password: "password", cheers: 12)
    user_find = User.find_by_credentials("samantha", "password")
    expect(new_user.id).to eq(user_find.id)
  end

end
