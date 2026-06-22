class SearchInvitationMailer < ApplicationMailer
  def existing_user_invitation(invitation, invited_user)
    @invitation = invitation
    @invited_user = invited_user
    @search = invitation.search
    @invited_by = invitation.invited_by

    mail(
      to: @invitation.email,
      subject: "#{@invited_by.name.presence || @invited_by.email} invited you to collaborate on #{@search.name}"
    )
  end

  def new_user_invitation(invitation)
    @invitation = invitation
    @search = invitation.search
    @invited_by = invitation.invited_by

    mail(
      to: @invitation.email,
      subject: "#{@invited_by.name.presence || @invited_by.email} invited you to Property Companion"
    )
  end
end
