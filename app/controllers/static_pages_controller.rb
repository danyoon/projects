class StaticPagesController < ApplicationController
  before_filter :find_day_start, :find_view_type

  require 'json'
  def index
    @title = 'Home'
    @user = current_user
    @location = request.location

    @mostly_connected = User.mostly_connected.limit(3)
  end

  def stanford
    @title = 'Stanford'
    @user = current_user
    @hotels = Hotel.where(city:"Palo Alto").paginate(page: params[:page])
  end

  def sf
    @title = 'San Francisco'
    @user = current_user
    @hotels = Hotel.where(city:"San Francisco").paginate(page: params[:page])        
  end

  def lv
    @title = 'Las Vegas'
    @user = current_user
    @hotels = Hotel.where(city:"Las Vegas").paginate(page: params[:page])        
  end

  def nyc
    @title = 'New York City'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def hst
    @title = 'Host Hotels and Resorts'
    @user = current_user
    @hotels = Hotel.where(owner:"Host Hotels and Resorts (HST)").paginate(page: params[:page])        
  end
 
  def drh
    @title = 'DiamondRock Hospitality'
    @user = current_user
    @hotels = Hotel.where(owner:"DiamondRock Hospitality (DRH)").paginate(page: params[:page])        
  end

  def sho
    @title = 'Sunstone Hotel Investors'
    @user = current_user
    @hotels = Hotel.where(owner:"Sunstone Hotel Investors (SHO)").paginate(page: params[:page])        
  end

  def lho
    @title = 'LaSalle Hotel Properties'
    @user = current_user
    @hotels = Hotel.where(owner:"LaSalle Hotel Properties (LHO)").paginate(page: params[:page])        
  end

  def bee
    @title = 'Strategic Hotels and Resorts'
    @user = current_user
    @hotels = Hotel.where(owner:"Strategic Hotel and Resorts (BEE)").paginate(page: params[:page])        
  end

  def peb
    @title = 'Pebblebrook Hotel Trust'
    @user = current_user
    @hotels = Hotel.where(owner:"Pebblebrook Hotel Trust (PEB)").paginate(page: params[:page])        
  end

  def chsp
    @title = 'Chesapeake Lodging Trust'
    @user = current_user
    @hotels = Hotel.where(owner:"Chesapeake Lodging Trust (CHSP)").paginate(page: params[:page])        
  end

  def ahp
    @title = 'Ashford Hospitality Prime'
    @user = current_user
    @hotels = Hotel.where(owner:"Ashford Hospitality Prime (AHP)").paginate(page: params[:page])        
  end

  def aht
    @title = 'Ashford Hospitality Trust'
    @user = current_user
    @hotels = Hotel.where(owner:"Ashford Hospitality Trust (AHT)").paginate(page: params[:page])        
  end

  def rlj
    @title = 'RLJ Lodging Trust'
    @user = current_user
    @hotels = Hotel.where(owner:"RLJ Lodging Trust (RLJ)").paginate(page: params[:page])        
  end

  def fch
    @title = 'Felcor Lodging Trust'
    @user = current_user
    @hotels = Hotel.where(owner:"Felcor Lodging Trust(FCH)").paginate(page: params[:page])        
  end

  def ht
    @title = 'Hersha Hospitality Trust'
    @user = current_user
    @hotels = Hotel.where(owner:"Hersha Hospitality (HT)").paginate(page: params[:page])        
  end

  def fch
    @title = 'Hospitality Property Trust'
    @user = current_user
    @hotels = Hotel.where(owner:"Hospitality Property Trust (HPT)").paginate(page: params[:page])        
  end


  def mgm
    @title = 'MGM Resorts International'
    @user = current_user
    @hotels = Hotel.where(owner:"MGM Resorts (MGM)").paginate(page: params[:page])        
  end

  def lvs
    @title = 'Las Vegas Sands Corp'
    @user = current_user
    @hotels = Hotel.where(owner:"Las Vegas Sands (LVS)").paginate(page: params[:page])        
  end

  def wynn
    @title = 'Wynn Resorts'
    @user = current_user
    @hotels = Hotel.where(owner:"Wynn Resorts (WYNN)").paginate(page: params[:page])        
  end

  def czr
    @title = 'Caesars Entertainment'
    @user = current_user
    @hotels = Hotel.where(owner:"Caesars Entertainment (CZR)").paginate(page: params[:page])        
  end

  def staticcontact
    @user = current_user
    @title = 'Contact Information'
  end

  def by_country
    @title = "Search by Country: #{params[:country_code]}"
    @user = current_user
    @hotels = Hotel.where(country: params[:country_code]).paginate(page: params[:page])
  end

  def by_city
    city_code = params[:city_code].underscore.humanize.titleize
    @title = "Search by City: #{city_code}"
    @user = current_user
    @hotels = Hotel.where(city: city_code).paginate(page: params[:page])
  end

private
  def find_day_start
    @day_start = if params[:day_start]
                   Date.parse(params[:day_start])
                 else
                   Date.today
                 end
  end

  def find_view_type
    @view_type = params[:view_type] ? params[:view_type].to_sym : :thumbnail
  end
end
