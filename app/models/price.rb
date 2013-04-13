class Price < ActiveRecord::Base
  attr_accessible :rate
  belongs_to :hotel
end
