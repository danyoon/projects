class AddDateStringToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :dateString, :string
  end
end
