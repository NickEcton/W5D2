class User < ApplicationRecord
  validates :username, presence: true
  validates :password_digest, presence: true
  validates :session_token, presence: true

  has_many :subs,
  foreign_key: :moderator_id,
  class_name: :Sub

  has_many :posts,
  foreign_key: :author_id,
  class_name: :Post

  after_initialize :ensure_session_token

  attr_reader :password

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    @user && @user.is_password?(password) ? @user : nil
  end
end
