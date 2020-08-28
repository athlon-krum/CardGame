module Api
  module V1
    class GamesController < ApplicationController
      def create
        raise CardGameError::NotAuthorized unless GamesPolicy.new(policy_context).create?

        result = Games::Create.call(create_params)

        if result.success?
          render json: result.game, status: :ok
        else
          render json: result.errors, status: :unprocessable_entity
        end
      end

      def draw
        game = GamePolicy::Scope.new(policy_context, Game).resolve.find(params[:id])

        raise CardGameError::NotAuthorized unless GamesPolicy.new(policy_context, game).draw_card?

        result = Games::DrawCard.call(game)

        if result.success?
          render json: result.card.to_h, status: :ok
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

