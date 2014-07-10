class SessionsController < ApplicationController
  
  def new
    if current_user
      redirect_to root_path
    end
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      cookies.permanent[:authentication_token] = user.authentication_token
      redirect_to edit_user_path(user) 
    else
      redirect_to request.referrer
    end
  end

  def show;end

  def destroy
    cookies.delete(:authentication_token)
    redirect_to root_url
  end
end
