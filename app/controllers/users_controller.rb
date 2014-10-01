class UsersController < ApplicationController
  before_action :authenticate_user!, only: %w[index show edit update destroy]
  before_action :authenticate_charter_rights!, only: %w[edit update destroy]
  before_action :find_user, only: %w[show edit update destroy]
  
  def index 
   @users = User.all
   @user = current_user
   @level_1_candidates = User.where(level: "L1 Candidate")
   @level_2_candidates = User.where(level: "L2 Candidate")
   @level_3_candidates = User.where(level: "L3 Candidate")
   @charterholders = User.where(level: "Charterholder")
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserDetail.create(user_id: @user.id)
      cookies.permanent[:authentication_token] = @user.authentication_token 
      redirect_to edit_user_path(@user)
    else
      flash[:error] = @user.errors.full_messages
      render 'new'
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
    if params[:user][:password].blank?
      @user_detail = @user.user_detail
      if @user.update_attributes(user_params)
        flash[:success] = "Updated successfully."
        redirect_to @user
      else
        render 'edit'
      end
    else
      if @user == @user.authenticate(params[:user][:current_password])
        @user_detail = @user.user_detail
        @user.update_attributes(user_params)
        flash[:success] = "Password Changed."
        redirect_to @user
      else
        flash[:error] = "Current Password is not a match."
        render 'edit'
      end
    end 
  end
  
  def destroy
    @user.destroy
    redirect_to root_path
  end
  
  def charterholders
    @users = User.all
    @user = current_user
    @level_1_candidates = User.where(level: "L1 Candidate")
    @level_2_candidates = User.where(level: "L2 Candidate")
    @level_3_candidates = User.where(level: "L3 Candidate")
    @charterholders = User.where(level: "Charterholder")
  end
  
  protected
  
  def user_params
   params.require(:user).permit(:prefix, :first_name, :middle_name, :last_name, :suffix, :email, :level, :password, :password_confirmation, :current_password, :access_code, {user_detail_attributes: [:id, :user_id, :instagram, :twitter, :facebook, :linkedin, :undergraduate_school, :graduate_school, :doctorate_school, :undergraduate_major, :graduate_major, :doctorate_major, :undergraduate_year, :graduate_year, :doctorate_year, :undergraduate_degree, :graduate_degree, :doctorate_degree, :year_of_charter, :certifications, :company, :title, :phone_number, :website, :industries, :interests, :skills, :city, :state, :zipcode, :bio]},  {user_profile_pictures_attributes: [:id, :user_id, :photo]})  
  end
  
  def find_user
    @user = User.friendly.find(params[:id])
  end
  
  
end



