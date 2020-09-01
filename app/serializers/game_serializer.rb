# frozen_string_literal: true

class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_player, :second_player

  def first_player
    object.player_1
  end

  def second_player
    object.player_2
  end
end
