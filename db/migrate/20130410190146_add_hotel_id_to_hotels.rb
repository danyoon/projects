class AddHotelIdToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :hotelID, :string
  end
end
