class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.integer :zipcode

      t.timestamps
    end
  end
end
