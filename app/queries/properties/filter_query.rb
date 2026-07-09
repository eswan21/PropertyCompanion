module Properties
  class FilterQuery
    def initialize(scope:, params:)
      @scope = scope
      @params = params
    end

    def call
      properties = @scope

      properties = filter_by_status(properties)
      properties = filter_by_price(properties)
      properties = filter_by_created_at(properties)
      properties = filter_by_last_event_at(properties)

      properties
    end

    private

    def filter_by_status(properties)
      return properties if @params[:status].blank?

      case @params[:status]
      when "open"
        properties.where(open: true)
      when "closed"
        properties.where(open: false)
      else
        properties
      end
    end

    def filter_by_price(properties)
      properties = properties.where("price_per_month >= ?", @params[:min_price]) if @params[:min_price].present?
      properties = properties.where("price_per_month <= ?", @params[:max_price]) if @params[:max_price].present?

      properties
    end

    def filter_by_created_at(properties)
      properties = properties.where("properties.created_at >= ?", Date.parse(@params[:created_from]).beginning_of_day) if @params[:created_from].present?
      properties = properties.where("properties.created_at <= ?", Date.parse(@params[:created_to]).end_of_day) if @params[:created_to].present?

      properties
    end

    def filter_by_last_event_at(properties)
      return properties if @params[:event_from].blank? && @params[:event_to].blank?

      properties = properties.left_joins(:property_events)

      if @params[:event_from].present?
        properties = properties.where(
          "property_events.created_at >= ?",
          Date.parse(@params[:event_from]).beginning_of_day
        )
      end

      if @params[:event_to].present?
        properties = properties.where(
          "property_events.created_at <= ?",
          Date.parse(@params[:event_to]).end_of_day
        )
      end

      properties.distinct
    end
  end
end