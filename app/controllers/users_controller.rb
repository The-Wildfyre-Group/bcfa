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
    @user_detail = @user.user_detail
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end 
  end
  
  def destroy
    @user.destroy
    redirect_to root_path
  end
  
  protected
  
  def user_params
   params.require(:user).permit(:prefix, :first_name, :middle_name, :last_name, :suffix, :email, :password, :password_confirmation, :access_code, {user_detail_attributes: [:id, :user_id, :instagram, :twitter, :facebook, :linkedin, :undergraduate_school, :graduate_school, :other_school, :undergraduate_degree, :graduate_degree, :other_degree, :year_of_charter, :certifications, :company, :title, :industries, :interests, :skills, :city, :state, :zipcode, :bio]},  {user_profile_pictures_attributes: [:id, :user_id, :photo]})  
  end
  
  def find_user
    @user = User.find(params[:id])
  end
  
  
end



