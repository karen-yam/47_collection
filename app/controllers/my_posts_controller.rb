class MyPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.includes(:prefecture, :category)
  end
end
