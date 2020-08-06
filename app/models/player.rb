class Player < ApplicationRecord
  belongs_to :game

  validates_presence_of :player_name
  validates :player_name, length: { minimum: 1, maximum: 25 }
end
