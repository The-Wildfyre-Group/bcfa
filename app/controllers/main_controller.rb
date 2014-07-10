class MainController < ApplicationController
  
  def index
    if current_user
      redirect_to home_path
    end 
  end
  
  def home
    @user = current_user
  end
  
 
   
end
