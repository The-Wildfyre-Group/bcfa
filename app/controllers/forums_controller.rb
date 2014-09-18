class ForumsController < ApplicationController
  before_action :authenticate_user!
  #TODO authenticate user
  
  def index
    @forums = Forum.all
    @user = current_user
  end
  
  def new
    @user = current_user
    @forum = Forum.new
  end
  
  def edit
    
  end
  
  def create
    @forum = Forum.new(forum_params)
    if @forum.save
      redirect_to @forum 
    else
      render :new
    end
  end
  
  def show
    @user = current_user
    @forum = Forum.find(params[:id])
    @topics = @forum.topics.sort {|a,b| b.last_post_at <=> a.last_post_at}
    @posts = Post.all.each.sort {|a,b| b.created_at <=> a.created_at}
  end
  
  protected
  
  def forum_params
    params.require(:forum).permit(:name, :description)
  end
  
end
