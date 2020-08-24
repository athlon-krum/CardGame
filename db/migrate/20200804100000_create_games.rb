class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.string :player_1, null: false
      t.string :player_2, null: false
      t.text :deck, null: false

      t.timestamps
    end
  end
end
