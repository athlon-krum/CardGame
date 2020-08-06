class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.belongs_to :deck
      t.integer :card_number
      t.string :suit

      t.timestamps
    end
  end
end
