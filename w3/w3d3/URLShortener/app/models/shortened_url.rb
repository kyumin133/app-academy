# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require "securerandom"

class ShortenedUrl < ActiveRecord::Base
  validates :user_id, :long_url, presence: true
  validates :short_url, uniqueness: true
  validate :no_spamming
  validate :nonpremium_max

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  has_many :taggings,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Tagging

  has_many :tags,
    through: :taggings,
    source: :tag

  def self.random_code
    random_string = ""
    loop do
      random_string = SecureRandom.urlsafe_base64(12)
      break unless ShortenedUrl.exists?(short_url: random_string)
    end
    random_string
  end

  def self.generate_shortened_url(user, long_url)
    ShortenedUrl.create(user_id: user.id, long_url: long_url, short_url: ShortenedUrl.random_code)
  end

  def self.prune(n)
    url_info = ShortenedUrl.select("shortened_urls.id, shortened_urls.user_id, shortened_urls.created_at AS url_created_at, MAX(visits.created_at) AS most_recent_visit").
      joins("LEFT OUTER JOIN visits ON visits.url_id = shortened_urls.id").
      group("shortened_urls.id")

    url_info.each do |url|
      next if User.find_by(id: url.user_id).premium
      if url.most_recent_visit.nil?
        if url.url_created_at < n.minutes.ago
          url.destroy
        end
      else
        if url.most_recent_visit < n.minutes.ago
          url.destroy
        end
      end
    end
  end

  def num_clicks
    self.visits.length
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.where(created_at: 10.minutes.ago..Time.now).select(:user_id).distinct.count
  end

  def no_spamming
    if ShortenedUrl.where(user_id: self.user_id, created_at: 1.minutes.ago..Time.now).count >= 5
      self.errors[:Cannot] << "create more than 5 URLs in a single minute"
    end
  end

  def nonpremium_max
    unless self.submitter.premium
      if ShortenedUrl.where(user_id: self.user_id).count >= 5
        self.errors[:Nonpremium] << "users can't create more than 5 URLS"
      end
    end
  end
end
