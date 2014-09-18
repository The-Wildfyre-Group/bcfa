class PostsController < ApplicationController
   before_action :authenticate_user!
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      @post.update_attributes(user_id: current_user.id)
      @topic = Topic.find(@post.topic_id)
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)
      flash[:notice] = "Successfully created post."
      redirect_to "/topics/#{@post.topic_id}"
    else
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to "/topics/#{@post.topic_id}"
    else
      render :edit
    end
  end
  
  def destroy
     @post = Post.find(params[:id])
     @post.destroy
     redirect_to "/topics/#{@post.topic_id}"
  end
  
  
  protected
  
  def post_params
    params.require(:post).permit(:content, :user_id, :topic_id)
  end
  
end
