class PricesController < ApplicationController
  require 'will_paginate'
  
  def historical
    @title = "Historical Prices"
    @user = current_user
    @hotels = @user.connected_hotels.all
    @price = Price.find(params[:id])
    @historical_prices = Price.find_all_by_date_for_and_hotel_id(@price.date_for,@price.hotel_id)
    @calendar_prices = Price.first(@price.hotel_id)
    render 'show'
  end

  def destroy
    @price = current_user.prices.where(:id => params[:id]).first
    if @price.present?
      @price.destroy
      flash[:success] = "Price deleted!"
    end
  end
end
