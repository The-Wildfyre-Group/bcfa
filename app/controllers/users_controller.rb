class UsersController < ApplicationController
  before_action :find_user, only: %w[show edit update destroy]
  
  def index 
   @users = User.all
   @user = current_user
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      #UserDetail.create(user_id: @user.id)
      cookies.permanent[:authentication_token] = @user.authentication_token 
      redirect_to edit_user_path(@user)
    else
      render text: @user.errors.full_messages
    end
  end
  
  def show
    @user_profile_picture = @user.user_profile_pictures.last
  end
  
  def edit
    @user_detail = @user.build_user_detail if @user.user_detail.nil?
    @user_detail = @user.user_detail
    @user_profile_picture = @user.user_profile_pictures.build if @user.user_profile_pictures.empty?
    @user_profile_picture = @user.user_profile_pictures.last
  end
  
  def update
    if !params[:user][:password]
      @user_detail = @user.user_detail
      if @user.update_attributes(user_params)
        redirect_to @user
      else
        render 'edit'
      end
    else
      if @user == @user.authenticate(params[:user][:current_password])
        @user_detail = @user.user_detail
        @user.update_attributes(user_params)
        redirect_to @user
      else
        flash[:error] = "Current Password is not a match."
      end
    end 
  end
  
  def destroy
    @user.destroy
    redirect_to root_path
  end
  
  protected
  
  def user_params
   params.require(:user).permit(:prefix, :first_name, :middle_name, :last_name, :suffix, :email, :password, :password_confirmation, :current_password, :access_code, {user_detail_attributes: [:id, :user_id, :instagram, :twitter, :facebook, :linkedin, :undergraduate_school, :graduate_school, :doctorate_school, :undergraduate_major, :graduate_major, :doctorate_major, :undergraduate_year, :graduate_year, :doctorate_year, :undergraduate_degree, :graduate_degree, :doctorate_degree, :year_of_charter, :certifications, :company, :title, :website, :industries, :interests, :skills, :city, :state, :zipcode, :bio]},  {user_profile_pictures_attributes: [:id, :user_id, :photo]})  
  end
  
  def find_user
    @user = User.find(params[:id])
  end
  
  
end



