class PostsController < ApplicationController

before_action :require_author, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:sub_id]
    @post.save
    flash[:errors] = @post.errors.full_messages
    redirect_to sub_url(@post.sub_id)
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy

  end

  def show

  end

  def require_author
    @post = Post.find(params[:id])
    if @post.author.username == current_user.username
    else
      flash[:errors] = "Not your post!"
      redirect_to sub_url(@post.sub_id)
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :author_id, :sub_id)
  end
end
