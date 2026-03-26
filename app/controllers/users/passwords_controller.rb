# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    user = User.find_by(email: params[:user][:email])

    if user&.provider.present?
      redirect_to new_user_password_path,
        alert: "このメールアドレスはGoogleログインのため、パスワードの変更はできません。Googleアカウントでログインしてください。"
    elsif params[:user][:email].blank?
      redirect_to new_user_password_path, alert: "メールアドレスを入力してください。"
    else
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      redirect_to new_user_session_path, notice: "パスワードリセットのメールを送信しました。メールをご確認ください。"
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end

  protected

  def after_resetting_password_path_for(resource)
    super(resource)
  end

  # The path used after sending reset password instructions
  # リセットパスワードの指示を送信した後に使用するpath
  def after_sending_reset_password_instructions_path_for(resource_name)
    new_user_session_path
  end
end
