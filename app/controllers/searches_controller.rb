class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search, only: [ :show ]

  def index
    @searches = current_user.searches
  end
  
  def show
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

  def set_search
    @search = current_user.searches.find(params[:id])
  end
end
