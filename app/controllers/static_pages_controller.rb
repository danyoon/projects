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
  end

  def sf
    @title = 'Home'
    @user = current_user        
  end

  def lv
    @title = 'Home'
    @user = current_user        
  end

  def nyc
    @title = 'Home'
    @user = current_user        
  end
 
  def statichotels
    @user = current_user    
    @hotels = Hotel.paginate(page: params[:page])
    @title = 'Help'
  end

  def staticblurb
    @user = current_user    
    @users = User.paginate(page: params[:page])
    @title = 'Mission Statement'
  end

  def staticcontact
    @user = current_user 
    @title = 'Contact Information'
  end
end
