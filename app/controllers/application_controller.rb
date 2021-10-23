class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :reject_inactive_user, if: :devise_controller?, only: [:create]

  protected

  def after_sign_in_path_for(resource)
    posts_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def reject_inactive_user
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_valid
        redirect_to new_user_session_path, notice: "退会済みです"
      end
    end
  end
end
