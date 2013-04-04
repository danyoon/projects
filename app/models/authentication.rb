class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :uid
  belongs_to :user

  def self.find_with_omniauth(omniauth)
    find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
  end
 
  def create_with_omniauth(omniauth)
    self.uid = omniauth['uid']
    self.provider = omniauth['provider'] # and other data you might want from the auth hash
  end
end
