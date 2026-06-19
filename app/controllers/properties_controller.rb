class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search
  before_action :set_property, only: [ :show, :update, :destroy, :toggle_status ]

  def show
    authorize @property
  end

  def create
    @property = @search.properties.build(property_params)
    authorize @property

    if @property.save
      redirect_to @search, notice: "Property created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @property

    if @property.update(property_params)
      redirect_to search_property_path(@search, @property), notice: "Property updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @property
    @property.destroy
    redirect_to search_path(@search), notice: "Property deleted successfully."
  end

  def toggle_status
    authorize @property, :update?
    if @property.open?
      @property.update!(open: false)
      event_type = "close"
      default_note = "Property was marked as closed"
    else
      @property.update!(open: true)
      event_type = "reopen"
      default_note = "Property was reopened"
    end

    @property.property_events.create!(
      event_type: event_type,
      note: params[:note].presence || default_note,
      creator: current_user
    )
    message =
      event_type == "close" ?
        "Property closed successfully." :
        "Property reopened successfully."

    redirect_to params[:return_to].presence || search_property_path(@search, @property), notice: message
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
    @search = policy_scope(Search).find(params[:search_id])
  end

  def set_property
    @property = @search.properties.find(params[:id])
  end
end
