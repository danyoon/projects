class AddDateForToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :date_for, :date
  end
end
