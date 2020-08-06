class Card < ApplicationRecord
  include Comparable

  CARD_SUITES = %w[spades diamonds hearts clubs].freeze
  CARD_SUITES_HASH = {'spades' => 1, 'diamonds' => 2, 'hearts' => 3, 'clubs' => 4}

  belongs_to :deck

  validates_presence_of :card_number
  validates_numericality_of :card_number, greater_than: 0, lower_than: 14
  validates_inclusion_of :suit, in: CARD_SUITES

  def <=>(other)
    if CARD_SUITES_HASH[suit] < CARD_SUITES_HASH[other.suit]
      -1
    elsif CARD_SUITES_HASH[suit] == CARD_SUITES_HASH[other.suit]
      0
    else
      1
    end
  end

  def self.draw_card(game_id)
    card = Card.where(deck_id: Game.find(game_id)).first
    Card.where(deck_id: Game.find(game_id))
      .delete(Card.where(deck_id: Game.find(game_id))[0])
    card
  end

  def format_for_humans
    if [1, 11, 12, 13].include?(card_number)
      case card_number
      when 1
        "Ace of #{suit.capitalize}"
      when 11
        "Jack of #{suit.capitalize}"
      when 12
        "Quuen of #{suit.capitalize}"
      else
        "King of #{suit.capitalize}"
      end
    else
      "#{card_number} of #{suit.capitalize}"
    end
  end
end
