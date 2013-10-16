class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page])
    @user = current_user
    @title = "All Users"        
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name    
    @summary_prices = @user.connected_hotels.paginate(page: params[:page])
  end

  def following
    @user = User.find(params[:id])
    @title = "Following"
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def connecting
    @user = User.find(params[:id])
    @title = "Connecting"
    @hotels = @user.connected_hotels.paginate(page: params[:page])
    render 'show_connect'
  end
end
