class HotelPermlink < ActiveRecord::Base
  attr_accessible :key, :sender_id, :hotel_id

  belongs_to :sender, class_name: 'User', counter_cache: true
  belongs_to :hotel, counter_cache: :permlinks_count

  def self.generate!(hotel)
    create!(key: SecureRandom.hex, hotel_id: hotel.id)
  end

  def to_param
    key
  end
end