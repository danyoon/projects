class HotelsController < ApplicationController
  require 'csv'

  def index
    @hotels = Hotel.paginate(page: params[:page])
    @title = "All Hotels"    
    respond_to do |format|
      format.html
      format.csv { send_data @hotels.to_csv }
    end
  end

  def import
    Hotel.import(params[:file])
  redirect_to hotels_url, notice: "Hotels imported."
  end
end
