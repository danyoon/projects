namespace :db do
  desc "Fill database with sample data"
  task makeusers: :environment do
    make_users
  end
  task makemicroposts: :environment do
    make_microposts
  end
  task makerelationships: :environment do
    make_relationships
  end
  task makehotels: :environment do
    make_hotels
  end
  task makenyprices: :environment do
    make_prices("New York")
  end
  task makesfprices: :environment do
    make_prices("San Francisco")
  end
  task makedcprices: :environment do
    make_prices("Washington")
  end
  task makecorvaraprices: :environment do
    make_prices("Corvara in Badia")
  end

  task makenypremium: :environment do
    make_premium("New York")    
  end
    task makesfpremium: :environment do
    make_premium("San Francisco")
  end
  task makedcpremium: :environment do
    make_premium("Washington")
  end
  task makecorvarapremium: :environment do
    make_premium("Corvara in Badia")
  end
end

def make_prices(cityName)
  #@hotelsString = arr.join(", ") 
  hotels= Hotel.find_all_by_city(cityName)
  hotels.each do |hotel|
    14.times do |index|
      firstDate = Date.today + index.day
      secondDate = firstDate + 1.day
      price = Price.find_or_create_by_hotel_id_and_date_for(hotel.id,firstDate)
      #if price.updated_at.to_i < Time.now.beginning_of_day.to_i
        api = Expedia::Api.new
        responseGL = api.get_list({:arrivalDate => firstDate.strftime("%m/%d/%Y"),:departureDate => secondDate.strftime("%m/%d/%Y"), :hotelIDList => hotel.hotelID, :room1 => "2", :options => "ROOM_RATE_DETAILS"})
        unless (responseGL.body['HotelListResponse']['HotelList']['HotelSummary']['RoomRateDetailsList']['RoomRateDetails']['RateInfos']['RateInfo']['ChargeableRateInfo']['@nightlyRateTotal'] rescue nil).nil?
            temp = BigDecimal.new (responseGL.body['HotelListResponse']['HotelList']['HotelSummary']['RoomRateDetailsList']['RoomRateDetails']['RateInfos']['RateInfo']['ChargeableRateInfo']['@nightlyRateTotal'])
            price.rate = temp
            price.date_for = firstDate
            price.save!
        else
            temp = 0.0
            price.rate = temp          
            price.date_for = firstDate
            price.save!
        end
      #end
    end
  end
end
  
def make_premium(cityName)
  #@hotelsString = arr.join(", ") 
  hotels= Hotel.find_all_by_city(cityName)
  hotels.each do |hotel|
    14.times do |index|
      firstDate = Date.today + index.day
      secondDate = firstDate + 1.day
      price = Price.find_or_create_by_hotel_id_and_date_for(hotel.id,firstDate)
      #if price.created_at.to_i < Time.now.beginning_of_day.to_i
        api = Expedia::Api.new
        responseGA = api.get_availability({:arrivalDate => firstDate.strftime("%m/%d/%Y"),:departureDate => secondDate.strftime("%m/%d/%Y"),:hotelID => hotel.hotelID, :supplierType => "E",:room1 => "2"})
        unless (responseGA.body['HotelRoomAvailabilityResponse']['HotelRoomResponse'] rescue nil).nil?
            #hotelID = responseGA.body['HotelRoomAvailabilityResponse']['hotelId']
            tempArray = responseGA.body['HotelRoomAvailabilityResponse']['HotelRoomResponse']
            tempArray.each do |t|
              unless (t['RateInfos']['RateInfo']['ChargeableRateInfo']['@nightlyRateTotal'] rescue nil).nil?
                temp = BigDecimal.new(t['RateInfos']['RateInfo']['ChargeableRateInfo']['@nightlyRateTotal'])
                if (price.rate > temp || price.rate == 0.0 || price.rate.nil? )
                  price.rate = temp
                  price.date_for = firstDate
                  price.save!
                end
              end
            end
        else
            temp = 0.0
            price.rate = temp          
            price.date_for = firstDate
            price.save!
        end
      #end
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
    
  #Alternative Code That Works
  #@api = Expedia::Api.new  
  #@responseGL = @api.get_list({:arrivalDate => firstDate.strftime("%m/%d/%Y"),:departureDate => secondDate.strftime("%m/%d/%Y"), :hotelIDList => "131734, 131734", :room1 => "2", :options => "ROOM_RATE_DETAILS"})
  #@hotelGL = responseGL.body['HotelListResponse']['HotelList']['HotelSummary']['hotelId']
    
  #More Results Test Code that Doesn't Work
  #if @response.body['HotelListResponse']['moreResultsAvailable']
  #@output = api.get_list ({:cacheKey => @response.body['HotelListResponse']['cacheKey'], :cacheLocation => @response.body['HotelListResponse']['cacheLocation']})
  #end


def make_hotels
  require 'csv'
  file = "db/hotels.csv"
  CSV.foreach(file, :headers => true) do |row|
    #Hotel.create!({ 
    #:name => row[2]
    #})
    Hotel.create!(row.to_hash)
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end
