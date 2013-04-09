class Hotel < ActiveRecord::Base
  attr_accessible :address, :city, :country, :name, :zipcode, :mainstreet, :crossstreet, :key, :owner, :image
end
