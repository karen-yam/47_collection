class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = current_user.posts.includes(:prefecture, :category)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: '投稿しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show;end

  def edit;end

  def update
    if @post.update(post_params)
      redirect_to @post, success: "更新しました"
    else
      flash.now[:danger] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, success: "投稿を削除しました"
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :prefecture_id, :category_id, :image, :image_cache)
  end


end
