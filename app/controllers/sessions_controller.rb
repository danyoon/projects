class SessionsController < ApplicationController  
  def new
    # Stuff to display on the login-page.
  end
  
  def create
    omniauth = request.env["omniauth.auth"]
 
    # Find an authentication or create an authentication
    @authentication = Authentication.find_with_omniauth(omniauth)
    if @authentication.nil?
      # If no authentication was found, create a brand new one here
      @authentication = Authentication.new
      @authentication.create_with_omniauth(omniauth)
    end
 
    if user_signed_in?
      if @authentication.user == current_user
        # User is signed in so they are trying to link an authentication with their
        # account. But we found the authentication and the user associated with it 
        # is the current user. So the authentication is already associated with 
        # this user. So let's display an error message.
        redirect_to signin_url, notice: "You have already linked this account"
      else
        # The authentication is not associated with the current_user so lets 
        # associate the authentication
        current_user.apply_omniauth(omniauth)
        @authentication.user = current_user
        @authentication.save
        redirect_to signin_url, notice: "Account successfully authenticated"
      end
    else # no user is signed_in
      if @authentication.user.present?
        # The authentication we found had a user associated with it so let's 
        # just log them in here
        cookies.permanent[:remember_token] = @authentication.user.remember_token
        current_user = @authentication.user
        redirect_to signin_url, notice: "Signed in!"
      else
        # The authentication has no user assigned and there is no user signed in
        # Our decision here is to create a new account for the user
        # But your app may do something different (eg. ask the user
        # if he already signed up with some other service)
        if @authentication.provider == 'identity'
          user = User.find(@authentication.uid)
          # If the provider is identity, then it means we already created a user
          # So we just load it up
          user.authentications << @authentication
          current_user = user
          redirect_to signin_url, notice: "Welcome to ThousandSoft!"
        else
          # otherwise we have to create a user with the auth hash
          user = User.new
          user.initialize_omniauth(omniauth)
          user.apply_omniauth(omniauth)
          # we will handle the different types of data we get back from providers at the model level in create_with_omniauth
          #if user.save
            user.authentications << @authentication
            cookies.permanent[:remember_token] = user.remember_token
            current_user = user
            flash[:notice] = "Signed in successfully."
            redirect_to signin_url, notice: "Signed In"
          #else
            #user.authentications << @authentication
            #self.current_user = user
            #session[:omniauth] = omniauth.except('extra')            
            #redirect_to new_user_registration_url
          #end
        end
      end
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url, notice: "Signed out!"
  end
  
  def failure  
    redirect_to root_url, alert: "Authentication failed, please try again."  
  end
end
