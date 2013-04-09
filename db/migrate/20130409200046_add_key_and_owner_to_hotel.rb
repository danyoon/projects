class AddKeyAndOwnerToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :key, :string
    add_column :hotels, :owner, :string
  end
end
