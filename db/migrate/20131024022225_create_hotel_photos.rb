class CreateHotelPhotos < ActiveRecord::Migration
  def change
    create_table :hotel_photos do |t|
      t.references :hotel
      t.references :user
      t.string :image
      t.timestamps
    end

    add_index :hotel_photos, :hotel_id
    add_index :hotel_photos, :user_id
  end
end
