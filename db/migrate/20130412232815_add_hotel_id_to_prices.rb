class AddHotelIdToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :hotel_id, :integer
  end
end
