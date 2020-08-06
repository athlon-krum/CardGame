class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.belongs_to :game
      t.string :player_name

      t.timestamps
    end
  end
end
