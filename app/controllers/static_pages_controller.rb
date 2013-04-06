class StaticPagesController < ApplicationController

  def home
    @title = 'Home'
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    require 'json'
    api1 = Expedia::Api.new
    #Hotel Kolfuschgerhof - Venere 279861
    @response1 = api1.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 279861, :supplierType => "V",:room1 => "1"})
    array1 = @response1.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate1 = array1[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate1 = array1[0]['RateInfos']['RateInfo']['ConvertedRateInfo']
    
    #['RateInfo']['ChargeableRateInfo']['@total']+"\n"

    api2 = Expedia::Api.new
    #Sporthotel Panorama - Venere 330337
    @response2 = api2.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 330337, :supplierType => "V",:room1 => "1"})
    array2 = @response2.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate2 = array2[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate2 = array2[0]['RateInfos']['RateInfo']['ConvertedRateInfo']
    


    api3 = Expedia::Api.new
    #Hotel Sassongher - Venere 365511
    @response3 = api3.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 365511, :supplierType => "V",:room1 => "1"})
    

    api4 = Expedia::Api.new    
    #Greif - Venere 375621
    @response4 = api4.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 375621, :supplierType => "E",:room1 => "1"})
    

    api5 = Expedia::Api.new    
    #Hotel Sassongher - Expedia 399390
    @response5 = api5.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 399390, :supplierType => "E",:room1 => "1"})
    

    api6 = Expedia::Api.new    
    #Domina Home Miramonti - Expedia 228143
    @response6 = api6.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 228143, :supplierType => "E",:room1 => "1"})
    

    api7 = Expedia::Api.new        
    #Hotel La Perla - Expedia 235624
    @response7 = api7.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 235624, :supplierType => "E",:room1 => "1"})
    
    #Col Alto
    #@response1 = api1.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 363469, :supplierType => "V",:room1 => "1"})
    #Sample API Code that Works
    #api= Expedia::Api.new    #
    #@response = api.get_list({:propertyName => 'Hotel Moa Berlin', :destinationString => 'berlin'})
    #puts @response
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
