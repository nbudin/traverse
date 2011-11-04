class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.references :playthrough, :null => false
      t.references :move, :null => false
      t.references :play_counter, :null => false
      t.timestamps
    end
  end
end
