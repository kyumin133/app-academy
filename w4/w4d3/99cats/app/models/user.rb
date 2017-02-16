# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true

  has_many :cats,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: :Cat

  has_many :sessions

  has_many :cat_rental_requests

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return user if user && user.is_password?(password)
  end

  def log_out_session!(session_token)
    current_session = self.sessions.find_by(session_token: session_token)
    current_session.destroy if current_session
  end

  def log_in_session!
    session_token = User.generate_session_token
    current_session = Session.new(session_token: session_token,user_id: self.id)
    current_session.save!
    session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
