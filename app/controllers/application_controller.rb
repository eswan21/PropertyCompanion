class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_admin_from_app
  before_action :store_invitation_token

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
    invitation = accept_pending_invitation_for(resource)

    return search_path(invitation.search) if invitation

    resource.admin? ? Avo.configuration.root_path : searches_path
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

  def store_invitation_token
    return unless params[:invitation_token].present?

    session[:invitation_token] = params[:invitation_token]
  end

  def accept_pending_invitation_for(user)
    return unless session[:invitation_token].present?

    invitation = SearchInvitation.find_by(token: session.delete(:invitation_token))
    return unless invitation

    if invitation.expired?
      flash[:alert] = "This invitation has expired."
      return
    end

    if invitation.accepted?
      flash[:notice] = "Invitation has already been accepted."
      return
    end

    return unless invitation.email.casecmp?(user.email)

    SearchPermission.find_or_create_by!(
      search: invitation.search,
      user: user
    )

    invitation.update!(accepted_at: Time.current)

    invitation
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
