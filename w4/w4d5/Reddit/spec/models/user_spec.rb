require 'rails_helper'
require 'rspec'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should have_many(:subs) }
  it { should have_many(:user_votes) }
  it { should have_many(:comments) }
end
