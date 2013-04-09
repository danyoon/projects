class AddMainstreetAndCrossstreetToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :mainstreet, :string
    add_column :hotels, :crossstreet, :string
  end
end
