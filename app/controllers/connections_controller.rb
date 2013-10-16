class ConnectionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @hotel = Hotel.find(params[:connection][:connected_id])
    current_user.connect!(@hotel)
    respond_to do |format|
      format.html { redirect_to @hotel }
      format.js
    end
  end

  def destroy
    @hotel = Connection.find(params[:id]).connected
    current_user.disconnect!(@hotel)
    respond_to do |format|
      format.html { redirect_to @hotel }
      format.js
    end
  end
end
