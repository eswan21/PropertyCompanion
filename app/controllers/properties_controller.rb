class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search
  before_action :set_property, only: [:show, :update, :destroy]

  def show
  end  

  def create
      @search = Search.find(params[:search_id])
      @property = @search.properties.build(property_params)

      if @property.save
      redirect_to @search
      else
      render :new, status: :unprocessable_entity
      end
  end

  def update
    if @property.update(property_params)
      redirect_to search_property_path(@search, @property)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    redirect_to search_path(@search)
  end

  private

  def property_params
      params.require(:property).permit(
      :title,
      :location,
      :price_per_month,
      :personal_priority,
      :url,
      :address,
      :postcode,
      :council_tax_band,
      :epc_rating,
      :disadvantages,
      :notes
      )
  end

  def set_search
    @search = current_user.searches.find(params[:search_id])
  end

  def set_property
    @property = @search.properties.find(params[:id])
  end
end
