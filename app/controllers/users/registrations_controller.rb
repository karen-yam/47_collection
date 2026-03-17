# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]

  # /users/edit にアクセスされたら新しい URL に転送
  def edit
    redirect_to edit_user_path(current_user)
  end

  def build_resource(hash = {})
    hash[:uid] = User.create_unique_string
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # 新規登録時に受け取れるパラメータを追加
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :bio, :is_published ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # プロフィール編集時に受け取れる
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :bio, :is_published ])
  # end

  # The path used after sign up for inactive accounts.
  # アクティブでないアカウントのサインアップ後に使用する path
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
