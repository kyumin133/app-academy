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

class Track < ActiveRecord::Base
  BONUS_REGULAR = ["Bonus", "Regular"]
  validates :album_id, :bonus_regular, :name, presence: true
  validates :name, uniqueness: true
  validates_inclusion_of :bonus_regular, in: BONUS_REGULAR

  belongs_to :album
  has_many :notes, dependent: :destroy
end
