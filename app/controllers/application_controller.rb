class ApplicationController < ActionController::Base
  protect_from_forgery

  # This tells Devise where to re-direct to after successful sign up or sign in
  def after_sign_in_path_for(user)
    user_url(user)
  end

  def twoweeks(hotelID)
    api = Expedia::Api.new        
    prices = Array.new(14)
    prices.each_with_index.map do |x, index|
      firstDate = Date.today + index.day
      secondDate = Date.today + 1.day + index.day
      responseGL = api.get_list({:arrivalDate => firstDate.strftime("%m/%d/%Y"),:departureDate => secondDate.strftime("%m/%d/%Y"), :hotelIDList => hotelID, :room1 => "2", :options => "ROOM_RATE_DETAILS"})
      if responseGL.exception?
        x = 0
      else
        x = responseGL.body['HotelListResponse']['HotelList']['HotelSummary']['RoomRateDetailsList']['RoomRateDetails']['RateInfos']['RateInfo']['ChargeableRateInfo']['@nightlyRateTotal']
      end
    end
  end
end
