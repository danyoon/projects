class Price < ActiveRecord::Base
  attr_accessible :rate, :date_for
  belongs_to :hotel
end
