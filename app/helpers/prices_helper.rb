module PricesHelper
  def average_price(hotels, params=nil)
    price = hotels.average_prices(params)
    if price
      "$" + number_with_precision(price, precision: 2)
    else
      "$0.00"
    end
  end
end