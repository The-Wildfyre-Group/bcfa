class TopicsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @topic = Topic.new
    @post = @topic.posts.build
    @user = current_user
    @posts = Post.all.each.sort {|a,b| b.created_at <=> a.created_at}
  end
  
  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)
      
     redirect_to forum_path(@topic.forum_id)
    else
      render :action => 'new'
    end
  end
  
  def show
    @topic = Topic.find(params[:id])
    @forum = Forum.find(@topic.forum_id)
    @user = current_user
    @first_post = @topic.posts.first
    @posts = Post.all.each.sort {|a,b| b.created_at <=> a.created_at}
    @controller = params[:controller]
    @action = params[:action]
    Visit.track(@topic, @controller, @action , request.remote_ip)
  end
  
  def edit
    
  end
  
  protected
  
  def topic_params
    params.require(:topic).permit(:name, :forum_id, :user_id, :last_poster_id, :last_post_at, posts_attributes: [:id, :topic_id, :user_id, :content, :_destroy] )
  end
  
  def find_forum
    @group = Group.find_by_slug!(params[:group_id]) 
    @forum = @group.forum
  end
  
end
