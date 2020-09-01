# frozen_string_literal: true

module Games
  class CreateContract < Reform::Form
    property :name
    property :first_player, from: :player_1
    property :second_player, from: :player_2

    validates :name,
      presence: :true,
      length: {
        minimum: 1,
        maximum: 254
      }
    validates :first_player,
      presence: true,
      length: {
        minimum: 1,
        maximum: 254
      }
    validates :second_player,
      presence: true,
      length: {
        minimum: 1,
        maximum: 254
      }
  end
end
