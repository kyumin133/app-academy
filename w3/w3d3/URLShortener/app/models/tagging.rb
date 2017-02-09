# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  tag_id     :integer          not null
#  url_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Tagging < ActiveRecord::Base
  validates :url_id, :tag_id, presence: true

  belongs_to :tag,
    primary_key: :id,
    foreign_key: :tag_id,
    class_name: :TagTopic

  belongs_to :url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl

  def self.tag_url!(shortened_url, tag_topic)
    Tagging.create!(url_id: shortened_url.id, tag_id: tag_topic.id)
  end
end
