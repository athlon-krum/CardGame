class Deck < ApplicationRecord
  belongs_to :game
  has_many :cards

  def self.create_deck(game_id)
    Deck.create({ game_id: game_id })
  end
end
