class UserPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    # 非公開ユーザーのコレクションは他ユーザーは見れない
    redirect_to root_path unless @user.is_published? || @user == current_user
    @posts = @user.posts.includes(:user, :prefecture, :category)
  end
end
