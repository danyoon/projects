class ConnectionsController < ApplicationController
  before_filter :find_hotel, :authenticate_user!

  def create
    current_user.connect!(@hotel)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    current_user.disconnect!(@hotel)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

private
  def find_hotel
    if action_name == "create"
      @hotel = Hotel.find(params[:connection][:connected_id])
    else
      @hotel = Connection.find(params[:id]).connected
    end
  end

  def authenticate_user!
    if action_name == "create"
      session[:redirect_type] = :add_connection
      session[:redirect_value] = @hotel.id
    end
    super
  end
end
