class StaticPagesController < ApplicationController
  require 'json'
  def index
    @title = 'Home'
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end

    @hash = Hash["New York", Hotel.find_all_by_city("New York"),
                "San Francisco", Hotel.find_all_by_city("San Francisco"), 
                "Washington DC", Hotel.find_all_by_city("Washington"),
                "Corvara/Cortina", Hotel.find_all_by_city("Corvara in Badia")] 
    
    #@hotelsString = arr.join(", ")
    hotels= Hotel.find_all_by_city("Washington")
    arr = Array.new
    hotels.each_with_index do |x,index|
      arr[index] = hotels[index][:hotelID]
    end

    #@firstDate = Date.new(2013,6,30)
    #@secondDate = Date.new(2013,7,1)    
    #firstDateNumber = @firstDate.yday
    #secondDateNumber = @firstDate.yday
    today = Date.today
    @dates = Array.new
    @prices = Array.new
    api = Expedia::Api.new    
    14.times do |index|
      firstDate = today + index.day
      secondDate = today + 1.day + index.day
      @dates[index] = firstDate
      @responseGL = api.get_list({:numberOfResults =>"20", :arrivalDate => firstDate.strftime("%m/%d/%Y"),:departureDate => secondDate.strftime("%m/%d/%Y"),:hotelIDList =>  "131734, 309378", :room1 => "2", :options => "ROOM_RATE_DETAILS"})
      if @responseGL.exception?
      else
        @hotelGL = @responseGL.body['HotelListResponse']['HotelList']['HotelSummary']['hotelId']
        @prices[index] = @responseGL.body['HotelListResponse']['HotelList']['HotelSummary']['RoomRateDetailsList']['RoomRateDetails']['RateInfos']['RateInfo']['ChargeableRateInfo']['@nightlyRateTotal']
      end
    end



    
    #
    #
    #ITALY
    #
    #
    #api1 = Expedia::Api.new
    #Hotel Kolfuschgerhof - Venere 279861
    #@response1 = api1.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 279861, :supplierType => "V",:room1 => "1"})
    #array1 = @response1.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate1 = array1[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate1 = array1[0]['RateInfos']['RateInfo']['ConvertedRateInfo']    

    #api2 = Expedia::Api.new
    #Sporthotel Panorama - Venere 330337
    #@response2 = api2.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 330337, :supplierType => "V",:room1 => "1"})
    #array2 = @response2.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate2 = array2[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate2 = array2[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api3 = Expedia::Api.new
    #Hotel Sassongher - Venere 365511
    #@response3 = api3.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 365511, :supplierType => "V",:room1 => "1"})
    

    #api4 = Expedia::Api.new    
    #Greif - Venere 375621
    #@response4 = api4.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 375621, :supplierType => "E",:room1 => "1"})

    #api5 = Expedia::Api.new    
    #Hotel Sassongher - Expedia 399390
    #@response5 = api5.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 399390, :supplierType => "E",:room1 => "1"})
 
    #api6 = Expedia::Api.new    
    #Domina Home Miramonti - Expedia 228143
    #@response6 = api6.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 228143, :supplierType => "E",:room1 => "1"})
    

    #api7 = Expedia::Api.new        
    #Hotel La Perla - Expedia 235624
    #@response7 = api7.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 235624, :supplierType => "E",:room1 => "1"})
    
    #Col Alto
    #@response1 = api1.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 363469, :supplierType => "V",:room1 => "1"})
    
    
    #Sample API Code that Works
    #api= Expedia::Api.new
    #@response = api.get_list({:propertyName => 'Hotel Moa Berlin', :destinationString => 'berlin'})
    #puts @response

    #Detailed Availability Code that Works
    #api= Expedia::Api.new
    #@responseGA = api.get_availability({:arrivalDate => @firstDateString,:departureDate => @secondDateString,:hotelID => "131734", :supplierType => "E",:room1 => "2"})
    #if @responseGA.exception?
    #else
      #@hotelGA = @responseGA.body['HotelRoomAvailabilityResponse']['hotelId']      
      #tempArray = @responseGA.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
      #@outputGA = tempArray[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #end 

    #More Results Test Code that Doesn't WOrk
    #if @response.body['HotelListResponse']['moreResultsAvailable']
    #@output = api.get_list ({:cacheKey => @response.body['HotelListResponse']['cacheKey'], :cacheLocation => @response.body['HotelListResponse']['cacheLocation']})
    #end
  
  end
  def home
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
