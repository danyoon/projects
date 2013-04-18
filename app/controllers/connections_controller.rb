class ConnectionsController < ApplicationController

  def create
    if user_signed_in?
      @hotel = Hotel.find(params[:connection][:connected_id])
      current_user.connect!(@hotel)
      respond_to do |format|
        format.html { redirect_to @hotel }
        format.js
      end
    end
  end

  def destroy
    if user_signed_in?
      @hotel = Connection.find(params[:id]).connected
      current_user.disconnect!(@hotel)
      respond_to do |format|
        format.html { redirect_to @hotel }
        format.js
      end
    end
  end
end
