class AddRateStringToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :rateString, :string
  end
end
