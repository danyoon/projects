class StaticPagesController < ApplicationController
  require 'json'
  def index
    @title = 'Home'
    @user = current_user
    @location = request.location
  end  

  def home
    @title = 'Home'
    if signed_in?
      @micropost  = current_user.microposts.build
      @userfeed_items = current_user.userfeed.paginate(page: params[:page])      
    end
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
