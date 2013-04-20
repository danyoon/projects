class StaticPagesController < ApplicationController
  require 'json'
  def index
    @title = 'Home'
    @user = current_user
    @hash = Hash["New York", Hotel.find_all_by_city("New York"),
                "San Francisco", Hotel.find_all_by_city("San Francisco"), 
                "Washington DC", Hotel.find_all_by_city("Washington"),
                "Corvara/Cortina", Hotel.find_all_by_city("Corvara in Badia")] 
  end  

  #@firstDate = Date.new(2013,6,30)
  #@secondDate = Date.new(2013,7,1)    
    #firstDateNumber = @firstDate.yday
    #secondDateNumber = @firstDate.yday

    #Sample API Code that Works
    #api= Expedia::Api.new
    #@response = api.get_list({:propertyName => 'Hotel Moa Berlin', :destinationString => 'berlin'})
    #puts @response

    #Detailed Availability Code that Works
    #api= Expedia::Api.new
    #@responseGA = api.get_availability({:arrivalDate => firstDate.strftrime("%m/%d/%Y"),:departureDate => secondDate.strftime("%m/%d/%Y"),:hotelID => "131734", :supplierType => "E",:room1 => "2"})
    #if @responseGA.exception?
    #else
      #@hotelGA = @responseGA.body['HotelRoomAvailabilityResponse']['hotelId']      
      #tempArray = @responseGA.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
      #@outputGA = tempArray[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #end 
    
    #Alternative Code That Works
    #@api = Expedia::Api.new  
    #@responseGL = @api.get_list({:arrivalDate => firstDate.strftime("%m/%d/%Y"),:departureDate => secondDate.strftime("%m/%d/%Y"), :hotelIDList => "131734, 131734", :room1 => "2", :options => "ROOM_RATE_DETAILS"})
    #@hotelGL = responseGL.body['HotelListResponse']['HotelList']['HotelSummary']['hotelId']
    

    #More Results Test Code that Doesn't WOrk
    #if @response.body['HotelListResponse']['moreResultsAvailable']
    #@output = api.get_list ({:cacheKey => @response.body['HotelListResponse']['cacheKey'], :cacheLocation => @response.body['HotelListResponse']['cacheLocation']})
    #end

  def home
    @title = 'Home'
    if signed_in?
      @micropost  = current_user.microposts.build
      @userfeed_items = current_user.userfeed.paginate(page: params[:page])
    end
  end
  
  def statichotels
    @hotels = Hotel.paginate(page: params[:page])
    @title = 'Help'
  end

  def staticusers
    @users = User.paginate(page: params[:page])
    @title = 'About'
  end

  def staticcontact
    @title = 'Contact'
  end
end
