module SearchInvitations
  class CreateService
    Result = Struct.new(:success?, :invitation)

    def initialize(search:, inviter:, email:)
      @search = search
      @inviter = inviter
      @email = email
    end

    def call
      invitation = @search.search_invitations.build(
        email: @email,
        invited_by: @inviter,
        expires_at: 7.days.from_now
      )

      return Result.new(false, invitation) unless invitation.save

      send_invitation_email(invitation)

      Result.new(true, invitation)
    end

    private

    def send_invitation_email(invitation)
      invited_user = User.find_by(email: invitation.email)

      if invited_user
        SearchInvitationMailer.existing_user_invitation(invitation, invited_user).deliver_later
      else
        SearchInvitationMailer.new_user_invitation(invitation).deliver_later
      end
    end
  end
end
