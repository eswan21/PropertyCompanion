module Api
  class BaseController < ApplicationController
    before_action :authenticate_api_key!

    private

    def authenticate_api_key!
      token = bearer_token

      if token.blank?
        render json: {
          error: "API key is required"
        }, status: :unauthorized

        return
      end

      @current_api_key = ApiKey.active.find_by(
        token_digest: ApiKey.digest(token)
      )

      unless @current_api_key
        render json: {
          error: "Invalid API key"
        }, status: :unauthorized

        return
      end

      @current_api_key.update_column(:last_used_at, Time.current)
    end

    def bearer_token
      authorization = request.headers["Authorization"]

      return if authorization.blank?

      match = authorization.match(/\ABearer\s+(.+)\z/i)
      match&.captures&.first
    end
  end
end
