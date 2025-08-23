class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice]
      posts_path
    else
      flash[:notice]
      posts_path
    end
  end

  protected

  def configure_permitted_parameters
    # /users/sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :email, :encrypted_password ])
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
