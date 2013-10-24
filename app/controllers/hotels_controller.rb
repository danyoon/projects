class HotelsController < ApplicationController
  before_filter :authenticate_user!, only: [:upload]

  require 'csv'

  def index
    @hotels = Hotel.paginate(page: params[:page])
    @user = current_user
    @title = "All Hotels"
    hotelsall = Hotel.order(:id)
    respond_to do |format|
      format.html
      format.csv { send_data hotelsall.to_csv }
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
    @user = current_user
    @prices = @hotel.prices.paginate(page: params[:page])
    @title = @hotel.name
  end

  def upload
    @hotel = Hotel.find(params[:id])

    previous = @hotel.photos.by_user(current_user)
    previous.destroy if previous

    current = @hotel.photos.create!(user_id: current_user.id, image: params[:hotel][:photo])

    redirect_to :back, notice: "Successfully uploaded photo."
  end

  def connecters
    @title = "Connecters"
    @user = User.find(params[:id])
    @users = @user.connecters.paginate(page: params[:page])
    render 'show_connect'
  end

  def self.search(search)
  if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end
end
