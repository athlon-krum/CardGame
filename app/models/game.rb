class Game < ApplicationRecord
  serialize :deck, Deck

  after_initialize :initialize_deck

  def draw_card
    return nil if deck.empty?

    deck.draw!
  end

  private

  def initialize_deck
    self.deck.shuffle!
  end
end
