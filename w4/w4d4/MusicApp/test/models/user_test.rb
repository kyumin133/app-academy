# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  password_digest  :string           not null
#  session_token    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  activated        :boolean          default("false"), not null
#  activation_token :string           not null
#  admin            :boolean          default("false"), not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
