module Api
  module V1
    class GamesController < ApplicationController
      def create
        raise ForbiddenError unless GamesPolicy.new(current_user).create?

        result = Games::Create.call(create_params)

        if result.success?
          render json: result.game, status: :ok
        else
          render json: result.errors, status: :unprocessable_entity
        end
      end

      private

      def create_params
        params.permit(:name, :player_1, :player_2)
      end
    end
  end
end

