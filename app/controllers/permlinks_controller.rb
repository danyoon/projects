class PermlinksController < ApplicationController
  def show
    permlink = HotelPermlink.find_by_key(params[:id])
    hotel = permlink.hotel

    if current_user and current_user.connecting?(hotel)
      redirect_to hotel_path(hotel), notice: "Already connected this hotel"
    elsif current_user
      current_user.connect!(hotel)
      redirect_to hotel_path(hotel), notice: "Successfully connect this hotel"
    else
      current_url = request.env['PATH_INFO']

      session[:redirect_url] = current_url
      redirect_to [:new, :user_session]
    end

  end
end
