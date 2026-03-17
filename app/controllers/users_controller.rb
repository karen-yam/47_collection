class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update update_email update_password]

  def show
    @user = current_user
  end

  # マイページ編集
  def edit
  end

  # プロフィール更新（名前・自己紹介・公開設定）
  def update
    if @user.update(profile_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # メール変更ページ
  def email_change
  end

  # メール更新
  def update_email
    if @user.update(email_params)
      redirect_to user_path(@user), notice: "メールアドレスを変更しました"
    else
      render :email_change, status: :unprocessable_entity
    end
  end

  # パスワード変更ページ
  def password_change
  end

  # パスワード変更
  def update_password
    if @user.update_with_password(password_params)
      bypass_sign_in(@user)
      redirect_to user_path(@user), notice: "パスワードを更新しました"
    else
      render :password_change, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def profile_params
    params.require(:user).permit(:name, :bio, :is_published)
  end

  def email_params
    params.require(:user).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
