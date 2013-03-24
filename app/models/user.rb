# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :microposts, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  VALID_NAME_REGEX = /\A[\w+\-.]+\s+[\w+\-.]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, format: { with: VALID_NAME_REGEX }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  has_many :microposts

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
