class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search, only: [ :show, :update, :destroy ]

  def index
    @searches = policy_scope(Search)
  end

  def show
    authorize @search
    @properties = @search.properties.by_priority
    @property = @search.properties.build
  end

  def create
    @search = current_user.searches.build(search_params)
    authorize @search

    if @search.save
      redirect_to searches_path
    else
      @searches = current_user.searches
      render :index, status: :unprocessable_entity
    end
  end

  def update
    authorize @search
    if @search.update(search_params)
      redirect_to searches_path
    else
      @searches = current_user.searches
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @search
    @search.destroy
    redirect_to searches_path
  end

  private

  def search_params
    params.require(:search).permit(:name)
  end

  def set_search
    @search = policy_scope(Search).find(params[:id])
  end
end
