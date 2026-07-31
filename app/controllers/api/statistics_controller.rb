module Api
  class StatisticsController < Api::BaseController
    def show
      date = parsed_date

      users = filter_by_date(User.all, date)
      properties = filter_by_date(Property.all, date)
      property_events = filter_by_date(PropertyEvent.all, date)

      render json: {
        total_users: users.count,
        total_properties: properties.count,
        total_notes: property_events.count,
        last_10_registration_emails: last_registration_emails(users),
        total_signed_in_via_google: google_users(users)
      }, status: :ok
    rescue Date::Error
      render json: {
        error: "Invalid date format. Use YYYY-MM-DD"
      }, status: :bad_request
    end

    private

    def parsed_date
      return if params[:date].blank?

      Date.iso8601(params[:date])
    end

    def filter_by_date(scope, date)
      return scope unless date

      scope.where(created_at: date.in_time_zone.all_day)
    end

    def last_registration_emails(users)
      users
        .order(created_at: :desc)
        .limit(10)
        .pluck(:email)
    end

    def google_users(users)
      users.where(provider: "google_oauth2").count
    end
  end
end
