module Api
  module V1
    class GamesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        game = Game.new(game_params)

        if game.save
          players = Player::create_players(game.id, player_params)
          deck = Deck::create_deck(game.id)
          deck.cards = Card::cards_create(deck.id)

          render json: { status: 'SUCCESS', message:'Created game.', data: players }, status: :ok
        else
          render json: { status: 'ERROR', message:'Game not created', data: game.errors }, status: :unprocessable_entity
        end
      end

      private

      def game_params
        params.permit(:game_name)
      end

      def player_params
        params.permit(:player_name)
      end
    end
  end
end

