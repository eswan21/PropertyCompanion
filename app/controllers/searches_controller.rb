class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search, only: [ :show, :update, :destroy ]

  def index
    @searches = current_user.searches
  end

  def show
    @properties = @search.properties.by_priority
    @property = @search.properties.build
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

  def update
    if @search.update(search_params)
      redirect_to searches_path
    else
      @searches = current_user.searches
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @search.destroy
    redirect_to searches_path
  end

  private

  def search_params
    params.require(:search).permit(:name)
  end

  def set_search
    @search = current_user.searches.find(params[:id])
  end
end
