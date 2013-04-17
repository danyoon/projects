class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :microposts, :dependent => :destroy
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :connections, foreign_key: "connecter_id", dependent: :destroy
  has_many :connected_hotels, through: :connections, source: :connected
  has_many :authentications

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    data = auth.info
    user = User.where(:email => data["email"]).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                        )
      user.authentications.build(provider:auth.provider, uid:auth.uid)
    end
    user
  end
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(name: data["name"],
                         email: data["email"],
                         password: Devise.friendly_token[0,20]
                        )
      user.authentications.build(provider:auth.provider, uid:auth.uid)
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def connecting?(other_hotel)
    connections.find_by_connected_id(other_hotel.id)
  end

  def connect!(other_hotel)
    connections.create!(connected_id: other_hotel.id)
  end

  def disconnect!(other_hotel)
    connections.find_by_connected_id(other_hotel.id).destroy
  end
end
