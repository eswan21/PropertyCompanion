class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(_resource)
    flash[:notice] = "Please check your email to confirm your account."
    new_user_session_path
  end
end
