class Game < ApplicationRecord
  has_one :deck
  has_many :players

  validates_presence_of :game_name
  validates :game_name, length: {
                                  minimum: 1,
                                  maximum: 254
                                }

  serialize :deck, Deck

  after_initialize :initialize_deck

  private

  def initialize_deck
    self.deck ||= Deck.new.shuffle!
  end
end
