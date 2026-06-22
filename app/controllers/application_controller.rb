class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_admin_from_app

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [ :name ]
    )

    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [ :name ]
    )
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      Avo.configuration.root_path
    else
      searches_path
    end
  end

  private

  def user_not_authorized
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  def redirect_admin_from_app
    return unless user_signed_in?
    return unless current_user.admin?
    return if request.path.start_with?(Avo.configuration.root_path)
    return if devise_controller?

    redirect_to Avo.configuration.root_path
  end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
