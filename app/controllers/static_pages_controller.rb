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
    
    @hotels= Hotel.find_all_by_city("San Francisco")
    @hotels.each do |hotel|
      price = Price.find_by_hotel_id(hotel[:id])
      if price
        if price.created_at.to_i > Time.now.beginning_of_day.to_i
          # do nothing if updated today
          #StaticPagesController.rates(hotel, price)
        else
          # if not updated today
          StaticPagesController.rates(hotel, price)
        end
      else
        # if no price record at all
        price = hotel.prices.build
        StaticPagesController.rates(hotel, price)
      end
    end
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

  def self.rates(hotel, price)
    api = Expedia::Api.new            
    dateArray = Array.new
    priceArray = Array.new
    2.times do |index|
      firstDate = Date.today + index.day
      secondDate = Date.today + 1.day + index.day
      responseGL = api.get_list({:arrivalDate => firstDate.strftime("%m/%d/%Y"),:departureDate => secondDate.strftime("%m/%d/%Y"), :hotelIDList => hotel[:hotelID], :room1 => "2", :options => "ROOM_RATE_DETAILS"})
      if responseGL.exception?
        dateArray.push(firstDate)
        priceArray.push(0)
      else
        dateArray.push(firstDate)
        priceArray.push(responseGL.body['HotelListResponse']['HotelList']['HotelSummary']['RoomRateDetailsList']['RoomRateDetails']['RateInfos']['RateInfo']['ChargeableRateInfo']['@nightlyRateTotal'])
      end
    end
    price.dateString = dateArray.join(',')
    price.rateString = priceArray.join(',')
    price.save
  end

  def self.array(string)
    array = string.to_s.split(",")
    return array
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
