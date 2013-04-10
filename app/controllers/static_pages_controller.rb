class StaticPagesController < ApplicationController
  def index
    @title = 'Home'
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    require 'json'
   
    @firstDate = Date.new(2013,6,7)
    @secondDate = Date.new(2013,6,8)
    firstDateString = @firstDate.strftime("%m/%d/%Y")
    secondDateString = @secondDate.strftime("%m/%d/%Y")
    firstDateNumber = @firstDate.yday
    secondDateNumber = @firstDate.yday

    @hash = Hash["New York", Hotel.find_all_by_city("New York"),
                "San Francisco", Hotel.find_all_by_city("San Francisco"), 
                "Washington DC", Hotel.find_all_by_city("Washington"),
                "Corvara/Cortina", Hotel.find_all_by_city("Corvara in Badia")] 
    
    @hotels= Hotel.find_all_by_city("New York")
    arr = Array.new
    @hotels.each_with_index do |x,index|
      arr[index] = @hotels[index][:name]
    end
    hotelsString = arr.join(", ")

    api = Expedia::Api.new
    @response = api.get_list({:arrivalDate => firstDateString,:departureDate => secondDateString,:hotelIDList =>  hotelsString, :room1 => "1"})

    if !@response.exception?
      @output = @response.body
    end
    #
    #
    #NEW YORK
    #
    #
    #api1ny = Expedia::Api.new
    #Four Seasons New York - Expedia 131734
    #@response1ny = api1ny.get_availability({:arrivalDate => firstDateString,:departureDate => secondDateString,:hotelID =>  131734, :supplierType => "E",:room1 => "1"})
    #array1ny = @response1ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate1ny = array1ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate1ny = array1ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api2ny = Expedia::Api.new
    #St. Regis New York - Expedia 309378
    #@response2ny = api2ny.get_availability({:arrivalDate => firstDateString,:departureDate => secondDateString,:hotelID => 309378, :supplierType => "E",:room1 => "1"})
    #array2ny = @response2ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate2ny = array2ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate2ny = array2ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api3ny = Expedia::Api.new
    #New York Marriott Marquis - Expedia 115902
    #@response3ny = api3ny.get_availability({:arrivalDate => firstDateString,:departureDate => secondDateString,:hotelID => 115902, :supplierType => "E",:room1 => "1"})
    #array3ny = @response3ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate3ny = array3ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate3ny = array3ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api4ny = Expedia::Api.new
    #W New York Lexington - Expedia 126897
    #@response4ny = api4ny.get_availability({:arrivalDate => firstDateString,:departureDate => secondDateString,:hotelID => 126897, :supplierType => "E",:room1 => "1"})
    #array4ny = @response4ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate4ny = array4ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate4ny = array4ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api5ny = Expedia::Api.new
    #W New York Union Square - Expedia 174141
    #@response5ny = api5ny.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 174141, :supplierType => "E",:room1 => "1"})
    #array5ny = @response5ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate5ny = array5ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate5ny = array5ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api6ny = Expedia::Api.new
    #Westin New York Grand Central - Expedia 416820
    #@response6ny = api6ny.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 416820, :supplierType => "E",:room1 => "1"})
    #array6ny = @response6ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate6ny = array6ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate6ny = array6ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api7ny = Expedia::Api.new
    #New York Marriott Downtown - Expedia 124520
    #@response7ny = api7ny.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 124520, :supplierType => "E",:room1 => "1"})
    #array7ny = @response7ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate7ny = array7ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate7ny = array7ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api8ny = Expedia::Api.new
    #Sheraton New York Times Square - Expedia 105816
    #@response8ny = api8ny.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 105816, :supplierType => "E",:room1 => "1"})
    #array8ny = @response8ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate8ny = array8ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate8ny = array8ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #array3sf = @response3sf.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate3sf = array3sf[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate3sf = array3sf[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api4sf = Expedia::Api.new
    #San Francisco Marriott Fisherman's Wharf - Expedia 106346
    #@response4sf = api4sf.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 106346, :supplierType => "E",:room1 => "1"})
    #array4sf = @response4sf.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate4sf = array4sf[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate4sf = array4sf[0]['RateInfos']['RateInfo']['ConvertedRateInfo']


    #api3dc = Expedia::Api.new
    #Washington Marriott at Metro Center - Expedia 107184
    #@response3dc = api3dc.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 107184, :supplierType => "E",:room1 => "1"})
    #array3dc = @response3dc.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate3dc = array3dc[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate3dc = array3dc[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api4dc = Expedia::Api.new
    #Hyatt Regency on Capitol Hill - Expedia 106037
    #@response4dc = api4dc.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 106037, :supplierType => "E",:room1 => "1"})
    #array4dc = @response4dc.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate4dc = array4dc[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate4dc = array4dc[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #api5dc = Expedia::Api.new
    #Westin Georgetown Washington D.C. - Expedia 130038
    #@response5dc = api5dc.get_availability({:arrivalDate => firstDateString,:departureDate => "06/15/2013",:hotelID => 130038, :supplierType => "E",:room1 => "1"})
    #array5dc = @response5dc.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate5dc = array5dc[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate5dc = array5dc[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

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
    #@response = api.get_availability({:arrivalDate => firstDateString,:departureDate => secondDateString,:hotelID =>  131734, :supplierType => "E",:room1 => "1"})
    #array = @response.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    #@chargeablerate = array[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    #@convertedrate = array[0]['RateInfos']['RateInfo']['ConvertedRateInfo']
    #puts @response
    
  
  end
  def home
    @title = 'Home'
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    require 'json'
    
    #
    #
    #NEW YORK
    #
    #
    api1ny = Expedia::Api.new
    #Four Seasons New York - Expedia 131734
    @response1ny = api1ny.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID =>  131734, :supplierType => "E",:room1 => "1"})
    array1ny = @response1ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate1ny = array1ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate1ny = array1ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api2ny = Expedia::Api.new
    #St. Regis New York - Expedia 309378
    @response2ny = api2ny.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 309378, :supplierType => "E",:room1 => "1"})
    array2ny = @response2ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate2ny = array2ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate2ny = array2ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api3ny = Expedia::Api.new
    #New York Marriott Marquis - Expedia 115902
    @response3ny = api3ny.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 115902, :supplierType => "E",:room1 => "1"})
    array3ny = @response3ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate3ny = array3ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate3ny = array3ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api4ny = Expedia::Api.new
    #W New York Lexington - Expedia 126897
    @response4ny = api4ny.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 126897, :supplierType => "E",:room1 => "1"})
    array4ny = @response4ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate4ny = array4ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate4ny = array4ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api5ny = Expedia::Api.new
    #W New York Union Square - Expedia 174141
    @response5ny = api5ny.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 174141, :supplierType => "E",:room1 => "1"})
    array5ny = @response5ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate5ny = array5ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate5ny = array5ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api6ny = Expedia::Api.new
    #Westin New York Grand Central - Expedia 416820
    @response6ny = api6ny.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 416820, :supplierType => "E",:room1 => "1"})
    array6ny = @response6ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate6ny = array6ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate6ny = array6ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api7ny = Expedia::Api.new
    #New York Marriott Downtown - Expedia 124520
    @response7ny = api7ny.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 124520, :supplierType => "E",:room1 => "1"})
    array7ny = @response7ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate7ny = array7ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate7ny = array7ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api8ny = Expedia::Api.new
    #Sheraton New York Times Square - Expedia 105816
    @response8ny = api8ny.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 105816, :supplierType => "E",:room1 => "1"})
    array8ny = @response8ny.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate8ny = array8ny[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate8ny = array8ny[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #
    #
    #SAN FRANCISCO
    #
    #
    api1sf = Expedia::Api.new
    #Ritz Carlton San Francisco - Expedia 124533
    @response1sf = api1sf.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 124533, :supplierType => "E",:room1 => "1"})
    array1sf = @response1sf.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate1sf = array1sf[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate1sf = array1sf[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api2sf = Expedia::Api.new
    #St. Regis San Francsico - Expedia 235570
    @response2sf = api2sf.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 235570, :supplierType => "E",:room1 => "1"})
    array2sf = @response2sf.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate2sf = array2sf[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate2sf = array2sf[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api3sf = Expedia::Api.new
    #San Francisco Marriott Marquis - Expedia 120243
    @response3sf = api3sf.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 120243, :supplierType => "E",:room1 => "1"})
    array3sf = @response3sf.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate3sf = array3sf[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate3sf = array3sf[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api4sf = Expedia::Api.new
    #San Francisco Marriott Fisherman's Wharf - Expedia 106346
    @response4sf = api4sf.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 106346, :supplierType => "E",:room1 => "1"})
    array4sf = @response4sf.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate4sf = array4sf[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate4sf = array4sf[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #
    #
    #WASHINGTON DC
    #
    #
    api1dc = Expedia::Api.new
    #Grand Hyatt Washington - Expedia 107272
    @response1dc = api1dc.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 107272, :supplierType => "E",:room1 => "1"})
    array1dc = @response1dc.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate1dc = array1dc[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate1dc = array1dc[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api2dc = Expedia::Api.new
    #JWMarriott Washington D.C. - Expedia 106309
    @response2dc = api2dc.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 106309, :supplierType => "E",:room1 => "1"})
    array2dc = @response2dc.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate2dc = array2dc[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate12dc = array2dc[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api3dc = Expedia::Api.new
    #Washington Marriott at Metro Center - Expedia 107184
    @response3dc = api3dc.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 107184, :supplierType => "E",:room1 => "1"})
    array3dc = @response3dc.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate3dc = array3dc[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate3dc = array3dc[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api4dc = Expedia::Api.new
    #Hyatt Regency on Capitol Hill - Expedia 106037
    @response4dc = api4dc.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 106037, :supplierType => "E",:room1 => "1"})
    array4dc = @response4dc.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate4dc = array4dc[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate4dc = array4dc[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    api5dc = Expedia::Api.new
    #Westin Georgetown Washington D.C. - Expedia 130038
    @response5dc = api5dc.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 130038, :supplierType => "E",:room1 => "1"})
    array5dc = @response5dc.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate5dc = array5dc[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate5dc = array5dc[0]['RateInfos']['RateInfo']['ConvertedRateInfo']

    #
    #
    #ITALY
    #
    #
    api1 = Expedia::Api.new
    #Hotel Kolfuschgerhof - Venere 279861
    @response1 = api1.get_availability({:arrivalDate => "06/14/2013",:departureDate => "06/15/2013",:hotelID => 279861, :supplierType => "V",:room1 => "1"})
    array1 = @response1.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    @chargeablerate1 = array1[0]['RateInfos']['RateInfo']['ChargeableRateInfo']
    @convertedrate1 = array1[0]['RateInfos']['RateInfo']['ConvertedRateInfo']    

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
