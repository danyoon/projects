class HotelPhoto < ActiveRecord::Base
  attr_accessible :user_id, :image

  belongs_to :hotel

  mount_uploader :image, HotelPhotoUploader

  def self.by_user(user)
    find_by_user_id(user.id)
  end
end