class MyPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.includes(:user, :prefecture, :category)
  end
end
