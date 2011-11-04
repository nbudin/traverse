class CreatePlayCounters < ActiveRecord::Migration
  def change
    create_table :play_counters do |t|
      t.references :counter, :null => false
      t.references :playthrough, :null => false
      t.references :current_node, :null => false
      t.timestamps
    end
  end
end
