class StaticPagesController < ApplicationController
  require 'json'
  def index
    @title = 'Home'
    @user = current_user
    @location = request.location
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
    @title = 'Host Hotels'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end
 
  def drh
    @title = 'DiamondRock Hospitality'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def sho
    @title = 'Sunstone Hotel Investors'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def lho
    @title = 'LaSalle Hotel Properties'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def bee
    @title = 'Strategic Hotels and Resorts'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def peb
    @title = 'Pebblebrook Hotel Trust'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def chsp
    @title = 'Chesapeake Lodging'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def aht
    @title = 'Ashford Hospitality'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def rlj
    @title = 'RLJ Lodging'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def mgm
    @title = 'MGM Resorts'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def lvs
    @title = 'Las Vegas Sands'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def wynn
    @title = 'Wynn Resorts'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def czr
    @title = 'Caesars Entertainment'
    @user = current_user
    @hotels = Hotel.where(city:"New York").paginate(page: params[:page])        
  end

  def statichotels
    @user = current_user    
    @hotels = Hotel.paginate(page: params[:page])
    @title = 'Help'
  end

  def staticcontact
    @user = current_user 
    @title = 'Contact Information'
  end
end
