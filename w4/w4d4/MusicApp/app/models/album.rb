# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  band_id     :integer          not null
#  name        :string           not null
#  live_studio :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Album < ActiveRecord::Base
  LIVE_STUDIO = %w(Live Studio)
  validates :band_id, :name, :live_studio, presence: true
  validates :name, uniqueness: true
  validates :live_studio, inclusion: { in: LIVE_STUDIO, message: "%{value} must be either Live or Studio" }

  belongs_to :band

  has_many :tracks, dependent: :destroy
end
