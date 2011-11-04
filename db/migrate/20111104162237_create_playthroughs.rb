class CreatePlaythroughs < ActiveRecord::Migration
  def change
    create_table :playthroughs do |t|
      t.string :name
      t.references :game, :null => false
      t.timestamps
    end
  end
end
