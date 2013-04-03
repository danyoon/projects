module SessionsHelper
  #def current_user
    #@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  #end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
