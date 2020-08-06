module Api
  module V1
    class CardsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :validate_game_id, :validate_deck_is_not_empty

      def show
        card = Card.where(deck_id: Game.find(params[:game_id]).deck.id).first

        render json: { status: 'SUCCESS', message: 'Valid request of card', data: card.format_for_humans }, status: :ok
      end

      def compare_cards
        card_1 = Card::draw_card(params[:game_id])
        card_2 = Card::draw_card(params[:game_id])

        if card_1.card_number == card_2.card_number && card_1.suit == card_2.suit
          render json: { status: 'ERROR', message: 'Cannot be identical' }, status: :unprocessable_entity
        elsif card_1.card_number == card_2.card_number
          render json: { status: 'SUCCESS', message: "#{card_1.format_for_humans}, #{card_1.format_for_humans}" }, status: :ok if card_1.suit < card_2.suit
        elsif card_1.card_number < card_2.card_number
          render json: { status: 'SUCCESS', message: "#{card_1.format_for_humans} is smaller value #{card_1.format_for_humans}" }, status: :ok
        elsif card_1.card_number > card_2.card_number
          render json: { status: 'SUCCESS', message: "#{card_1.format_for_humans} is greater value #{card_1.format_for_humans}" }, status: :ok
        end
      end

      def validate_game_id
        render json: { status: 'ERROR', message: 'Invalid game id' }, status: :unprocessable_entity unless Game.find(params[:game_id])
      end

      def validate_deck_is_not_empty
        render json: { status: 'ERROR', message: 'Empty deck' }, status: :unprocessable_entity if Card.where(deck_id: Game.find(params[:game_id]).deck.id).empty?
      end
    end
  end
end
