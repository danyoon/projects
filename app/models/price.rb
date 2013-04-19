class Price < ActiveRecord::Base
  attr_accessible :rate, :date_for
  belongs_to :hotel

  validates :hotel_id, presence: true

  def self.from_hotels_connected_to(user)
    connected_user_ids = "SELECT connected_id FROM connections
                         WHERE connecter_id = :hotel_id"
    where("hotel_id IN (#{connected_user_ids})", hotel_id: user.id)
  end
end
