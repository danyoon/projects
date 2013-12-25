class Admin::HotelsController < Admin::ApplicationController
  require 'csv'

  def index
    @hotels = Hotel.paginate(page: params[:page])
    @hotelsfull = Hotel.order(:id)
    respond_to do |format|
      format.html
      format.csv { render text: @hotelsfull.to_csv }
    end
  end

  def edit
    @hotel = Hotel.find(params[:id])
  end

  def update
    @hotel = Hotel.find(params[:id])
    @hotel.update_attributes!(params[:hotel])
    redirect_to [:admin, :hotels]
  end

  def import
    Hotel.import(params[:file])
    redirect_to [:admin, :root], notice: "Hotels imported."
  end
end
