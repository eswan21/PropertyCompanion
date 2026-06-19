class PropertyEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search
  before_action :set_property

  def create
    @property_event = @property.property_events.build(property_event_params)
    @property_event.creator = current_user

    authorize @property_event

    redirect_path = params[:return_to].presence || search_property_path(@search, @property)

    if @property_event.save
      redirect_to redirect_path,
              notice: "#{@property_event.event_type.humanize} event added successfully."
    else
      redirect_to redirect_path,
                  alert: "Event could not be added."
    end
  end

  private

  def set_search
    @search = policy_scope(Search).find(params[:search_id])
  end

  def set_property
    @property = @search.properties.find(params[:property_id])
  end

  def property_event_params
    params.require(:property_event).permit(:event_type, :note)
  end
end
