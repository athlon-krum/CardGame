module Api
  module V1
    class GamesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        game = Game.new(game_params)

        if game.save
          create_deck(game.id)
          players = create_players(game.id)

          render json: { status: 'SUCCESS', message:'Created game.', data: players }, status: :ok
        else
          render json: { status: 'ERROR', message:'Game not created', data: game.errors }, status: :unprocessable_entity
        end
      end

      private

      def create_players(game_id)
        player_1 = Player.new({game_id: game_id, player_name: player_params[:player_name].split(',')[0].strip })
        player_2 = Player.new({game_id: game_id, player_name: player_params[:player_name].split(',')[1].strip })

        false unless player_1.save && player_2.save
        [player_1, player_2]
      end

      def create_deck(game_id)
        deck = Deck.create({ game_id: game_id })

        deck.cards = cards_create(deck.id)
      end

      def cards_create(deck_id)
        cards = Array.new
        (1..13).to_a.each do |i|
          %w[spades diamonds hearts clubs].each do |suit|
            card = Card.new({ deck_id: deck_id, card_number: i, suit: suit })
            cards << card
          end
        end
        cards.shuffle!.each { |c| c.save }
        cards
      end

      def game_params
        params.permit(:game_name)
      end

      def player_params
        params.permit(:player_name)
      end
    end
  end
end

