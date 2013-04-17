class HotelsController < ApplicationController
  require 'csv'

  def index
    @hotels = Hotel.paginate(page: params[:page])
    @title = "All Hotels"    
    hotelsall = Hotel.order(:id)
    respond_to do |format|
      format.html
      format.csv { send_data hotelsall.to_csv }
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
    #@prices = @hotel.prices.paginate(page: params[:page])
    @title = @hotel.name
  end

  def import
    Hotel.import(params[:file])
  redirect_to hotels_url, notice: "Hotels imported."
  end
end
