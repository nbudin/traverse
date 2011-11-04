class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.references :game, :null => false
      t.references :start_node
      t.string :name, :null => false
      t.string :description
      
      t.timestamps
    end
  end
end
