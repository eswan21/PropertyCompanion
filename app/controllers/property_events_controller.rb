class PropertyEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search
  before_action :set_property

  def create
    @property_event = @property.property_events.build(property_event_params)
    @property_event.creator = current_user

    if @property_event.save
      redirect_back fallback_location: search_property_path(@search, @property)
    else
      redirect_back fallback_location: search_property_path(@search, @property),
                    alert: "Event could not be added."
    end
  end

  private

  def set_search
    @search = current_user.searches.find(params[:search_id])
  end

  def set_property
    @property = @search.properties.find(params[:property_id])
  end

  def property_event_params
    params.require(:property_event).permit(:event_type, :note)
  end
end
