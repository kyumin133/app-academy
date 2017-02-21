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

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, :cheers, presence: true
  validates :username, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many :user_page_comments,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :UserComment

  has_many :user_author_comments,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :UserComment

  has_many :goal_page_comments,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :GoalComment

  has_many :comments

  has_many :goals

  attr_reader :password


  after_initialize :ensure_session_token
  after_initialize :ensure_cheers


  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def ensure_cheers
    self.cheers ||= 12
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    return nil unless @user
    @user.is_password?(password) ? @user : nil
  end
end
