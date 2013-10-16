class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    case session[:redirect_type]
    when :add_connection
      hotel = Hotel.find(session[:redirect_value])
      current_user.connect!(hotel)
    end

    session.delete(session[:redirect_type])
    session.delete(session[:redirect_value])

    current_user
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
end
