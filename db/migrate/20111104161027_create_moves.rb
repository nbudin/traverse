class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :from_node, :null => false
      t.references :to_node, :null => false
      t.text :name
      t.text :instructions
      
      t.timestamps
    end
  end
end
