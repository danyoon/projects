class StaticPagesController < ApplicationController
  require 'json'
  def index
    @title = 'Home'
    @user = current_user
    @location = request.location
  end  

  def stanford
    @title = 'Home'
    @user = current_user
    @hotels = Hotel.where(city:"Palo Alto").paginate(page: params[:page])
  end

  def sf
    @title = 'Home'
    @user = current_user
    @hotels = Hotel.where(city:"San Francisco").paginate(page: params[:page])        
  end

  def lv
    @title = 'Home'
    @user = current_user
    @hotels = Hotel.where(city:"Las Vegas").paginate(page: params[:page])        
  end

  def nyc
    @title = 'Home'
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
