class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @searches = current_user.searches
  end

  def create
    @search = current_user.searches.build(search_params)

    if @search.save
      redirect_to searches_path
    else
      @searches = current_user.searches
      render :index, status: :unprocessable_entity
    end
  end

  private

  def search_params
    params.require(:search).permit(:name)
  end
end
