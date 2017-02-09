# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class TagTopic < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_id,
    class_name: :Tagging

  has_many :urls,
    through: :taggings,
    source: :url

  def popular_links
    top_urls = self.urls.sort_by { |url| -url.num_clicks }.take(5)
    top_url_info = []
    top_urls.each do |url|
      top_url_info << { url_id: url.id, long_url: url.long_url, num_visits: url.num_clicks }
    end
    top_url_info
  end
  # #
  # <<-SQL
  # select
  #   -- url_id, COUNT()
  # from
  #   tag_topics
  # join
  #
  # ORDER BY
  #   COUNT() DESC
  # SQL
end
