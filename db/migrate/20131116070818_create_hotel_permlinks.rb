class CreateHotelPermlinks < ActiveRecord::Migration
  def change
    create_table :hotel_permlinks do |t|
      t.string :key
      t.integer :sender_id
      t.integer :hotel_id
      t.timestamps
    end

    add_index :hotel_permlinks, [:key, :sender_id, :hotel_id]

    add_column :users, :hotel_permlinks_count, :integer, default: 0
    add_column :hotels, :permlinks_count, :integer, default: 0
  end
end
