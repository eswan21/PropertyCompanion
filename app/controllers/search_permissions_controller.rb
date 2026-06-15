class SearchPermissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search


  def create
    user = User.find_by(email: params[:search_permission][:email])

    unless user
      redirect_to @search, alert: "User not found."
      return
    end

    if user == @search.user
      redirect_to @search, alert: "Search owner already has access."
      return
    end

    @search_permission = @search.search_permissions.build(user: user)

    authorize @search_permission

    if @search_permission.save
      redirect_to @search, notice: "Access granted successfully."
    else
      redirect_to @search,
                  alert: @search_permission.errors.full_messages.to_sentence
    end
  end

  def destroy
    @search_permission = @search.search_permissions.find(params[:id])
    authorize @search_permission
    @search_permission.destroy
    redirect_to @search, notice: "Access removed successfully."
  end

  private

  def set_search
    @search = policy_scope(Search).find(params[:search_id])
  end
end
