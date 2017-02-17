# == Schema Information
#
# Table name: tracks
#
#  id            :integer          not null, primary key
#  album_id      :integer          not null
#  bonus_regular :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string           not null
#

require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
