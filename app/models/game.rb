class Game < ApplicationRecord
  validates_presence_of :name
  validates :name, length: {
                             minimum: 1,
                             maximum: 254
                           }

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
