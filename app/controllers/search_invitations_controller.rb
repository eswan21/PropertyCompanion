class SearchInvitationsController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]
  before_action :set_search, only: [ :create ]

  def create
    result = SearchInvitations::CreateService.new(
      search: @search,
      inviter: current_user,
      email: params[:search_invitation][:email]
    ).call

    if result.success?
      redirect_to @search, notice: "Invitation sent successfully."
    else
      redirect_to @search, alert: result.invitation.errors.full_messages.to_sentence
    end
  end

  private

  def set_search
    @search = policy_scope(Search).find(params[:search_id])
  end
end
