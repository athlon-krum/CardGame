module Api
  module V1
    class ApplicationController < ::ApplicationController
      skip_before_action :verify_authenticity_token

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from CardGameError::NotAuthorized, with: :not_authorized

      private

      def not_found(exception)
        render json: { errors: [exception.message] }, status: :not_found
      end

      def not_authorized(exception)
        render json: { errors: [exception.message] }, status: :forbidden
      end
    end
  end
end
