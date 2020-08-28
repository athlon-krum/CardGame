module Api
  module V1
    class CardsController < ApplicationController
      def compare
        raise CardGameError::NotAuthorized unless CardsPolicy.new(policy_context).compare?

        result = Cards::Compare.call(compare_params)

        if result.success?
          render json: { winner: result.highest.to_s }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def compare_params
        params.require(:cards).permit([])
      end
    end
  end
end
