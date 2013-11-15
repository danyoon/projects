class UsersController < ApplicationController
  before_filter :find_day_start, :find_view_type

  def index
    @users = User.paginate(page: params[:page])
    @user = current_user
    @title = "All Users"        
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name    
    @hotels = @user.connected_hotels
    @summary_prices = @hotels.paginate(page: params[:page])
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
