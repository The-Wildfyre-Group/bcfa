class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def http_basic_authenticate
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |username, password|
        username == "spa" && password == "spa"
      end
    else
      true
    end
  end
  
  # users
  
  def test_for_me?
    
  end
  
  def new_user
    @user ||= User.new
  end
  
  def current_user
    @current_user ||= User.find_by_authentication_token(cookies[:authentication_token]) if cookies[:authentication_token]
  end
  
  helper_method :new_user, :current_user, :test_for_me?
end
