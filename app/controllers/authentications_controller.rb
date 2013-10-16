class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @authentications = current_user.authentications
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_with_omniauth(omniauth)
    if @authentication.nil?
      # If no authentication was found, create a brand new one here
      @authentication = Authentication.create_with_omniauth(omniauth)
    end

    if current_user
      current_user.apply_omniauth(omniauth)
      @authentication.user = current_user
      @authentication.save
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
