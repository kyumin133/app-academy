# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, presence: true
  validate :require_sub
  after_save :set_subs
  before_update :require_sub_update
  after_update :set_subs

  has_many :comments, dependent: :destroy
  has_many :post_subs, dependent: :destroy

  has_many :subs,
    through: :post_subs,
    source: :sub,
    dependent: :destroy

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  attr_reader :sub_ids

  def require_sub_update
    # fail
    if @sub_ids.empty?
      self.errors["Post"] << "must have at least one sub."
    end
  end

  def require_sub
    @sub_ids ||= []
    if @sub_ids.empty?
      self.errors["Post"] << "must have at least one sub."
    end
  end

  def sub_ids=(sub_ids)
    @sub_ids = sub_ids
  end

  def set_subs
    PostSub.where(post_id: self.id).each do |post_sub|
      post_sub.destroy unless @sub_ids.include?(post_sub.sub_id)
    end

    @sub_ids.each do |sub_id|
      ps = PostSub.find_by(post_id: self.id, sub_id: sub_id)
      if ps.nil?
        PostSub.create(post_id: self.id, sub_id: sub_id)
      else
        PostSub.update(post_id: self.id, sub_id: sub_id)
      end
    end
  end

  def comments_by_parent_id
    comments_hash = Hash.new { |h, k| h[k] = [] }
    self.comments.includes(:author).each do |comment|
      comments_hash[comment.parent_comment_id] << comment
      # p comments_hash[comment.parent_comment_id]
    end
    # p comments
    comments_hash
  end
end
