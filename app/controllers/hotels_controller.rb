class HotelsController < ApplicationController
  before_filter :login_required, only: [:upload, :send_user]

  require 'csv'

  def index
    @hotels = Hotel.paginate(page: params[:page])
    @user = current_user
    @title = "All Hotels"
  end

  def show
    @hotel = Hotel.find(params[:id])
    @user = current_user
    @prices = @hotel.prices.paginate(page: params[:page])
    @title = @hotel.name
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(params[:hotel])
    @hotel.save!

    current_user.connect!(@hotel) if current_user

    redirect_to @hotel
  end

  def upload
    @hotel = Hotel.find(params[:id])

    previous = @hotel.photos.by_user(current_user)
    previous.destroy if previous

    current = @hotel.photos.create!(user_id: current_user.id, image: params[:hotel][:photo])

    current_user.connect!(@hotel)

    redirect_to :back, notice: "Successfully uploaded photo."
  end

  def connecters
    @title = "Connecters"
    @user = User.find(params[:id])
    @users = @user.connecters.paginate(page: params[:page])
    render 'show_connect'
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def send_user_form
    @hotel = Hotel.find(params[:id])
  end

  def send_user
    @hotel = Hotel.find(params[:id])

    if params[:user].index("@") == nil
      @user = User.find_by_name(params[:user])

      if !@user
        redirect_to :back, alert: "can't find user named \"#{params[:user]}\""
      elsif @user.connecting?(@hotel)
        redirect_to :back, alert: "\"#{params[:user]}\" is already connecting this hotel"
      else
        @user.connect!(@hotel)
        redirect_to :back, notice: "Successfully send hotel to \"#{params[:user]}\""
      end
    else
      permlink = current_user.hotel_permlinks.generate!(@hotel)
      link = Rails.application.routes.url_helpers.permlink_url(permlink)

      arguments = {
        from: "noreply@thousandsoft.com",
        to: params[:user],
        subject: "#{current_user.name} sent information of \"#{@hotel.name}\"",
        html: "see the <a href=\"#{link}\" target=\"_blank\">link</a>"
      }

      Mailgun().messages.send_email(arguments)

      redirect_to :back, notice: "Successfully send a hotel to \"#{params[:user]}\""
    end
  end

private
  def login_required
    unless user_signed_in?
      session[:redirect_url] = request.referer
      redirect_to [:new, :user_session]
    end
  end
end
