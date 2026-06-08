class PropertyEventsController < ApplicationController
  before_action :set_property

  def new
    @property_event = @property.property_events.build
  end

  def create
    @property_event = @property.property_events.build(property_event_params)
    @property_event.creator = current_user

    if @property_event.save
      redirect_to search_property_path(@property.search, @property)
    else
      render :new, status: :unprocessable_entity
    end

    # if @property_event.save
    #   redirect_back fallback_location: @property, notice: "Event was added."
    # else
    #   redirect_back fallback_location: @property, alert: "Event could not be added."
    # end
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end

  def property_event_params
    params.require(:property_event).permit(:event_type, :note)
  end
end
