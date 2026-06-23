class SearchPermissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search

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
