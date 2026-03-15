class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.provider.present?
      flash[:notice] = "Googleログインしました。投稿する場合は公開設定を確認してください。"
      posts_path
    else
      posts_path
    end
  end

  protected

  def configure_permitted_parameters
    # /users/sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :is_published])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :is_published, :bio])
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
