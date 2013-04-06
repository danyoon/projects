class StaticPagesController < ApplicationController

  def home
    api = Expedia::Api.new
    #@response = api.get_availability({:arrivalDate => "05/24/2013",:departureDate => "05/25/2013",:hotelID => 279861,:supplierType => "v",:room1 => "1"})
    @response = api.get_list({:propertyName => 'Hotel Moa Berlin', :destinationString => 'berlin'})
    respond_to do |format|
      format.html
      format.json { render json: @response.body }
    end
    puts @response.body
    @title = 'Home'
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def help
    @title = 'Help'
  end

  def about
    @title = 'About'
  end

  def contact
    @title = 'Contact'
  end
end
