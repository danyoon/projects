class PricesController < ApplicationController

  def historical
    @title = "Historical Prices"
    @user = current_user
    @hotels = @user.connected_hotels.all
    @historicalprice = Price.find(params[:id])
    @historicalprices = Price.find_all_by_date_for_and_hotel_id(@historicalprice.date_for,@historicalprice.hotel_id)
    render 'show_historical'
  end

  def destroy
    @price = current_user.prices.where(:id => params[:id]).first
    if @price.present?
      @price.destroy
      flash[:success] = "Price deleted!"
    end
  end
end
