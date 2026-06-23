class SearchInvitationsController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]
  before_action :set_search, only: [ :create ]

  def create
    invitation = @search.search_invitations.build(
      email: params[:search_invitation][:email],
      invited_by: current_user,
      expires_at: 7.days.from_now
    )

    if invitation.save
      invited_user = User.find_by(email: invitation.email)

      if invited_user
        SearchInvitationMailer.existing_user_invitation(invitation, invited_user).deliver_later
      else
        SearchInvitationMailer.new_user_invitation(invitation).deliver_later
      end

      redirect_to @search, notice: "Invitation sent successfully."
    else
      redirect_to @search, alert: invitation.errors.full_messages.to_sentence
    end
  end

  private

  def set_search
    @search = policy_scope(Search).find(params[:search_id])
  end
end
