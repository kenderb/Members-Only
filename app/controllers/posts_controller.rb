class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = current_user.posts.build
  end

  def edit; end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to root_path, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
