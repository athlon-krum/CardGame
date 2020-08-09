class Player < ApplicationRecord
  belongs_to :game

  validates_presence_of :player_name
  validates :player_name, length: { minimum: 1, maximum: 25 }

  def self.create_players(game_id, player_params)
    player_1 = Player.new({game_id: game_id, player_name: player_params[:player_name].split(',')[0].strip })
    player_2 = Player.new({game_id: game_id, player_name: player_params[:player_name].split(',')[1].strip })

    false unless player_1.save && player_2.save
    [player_1, player_2]
  end
end
