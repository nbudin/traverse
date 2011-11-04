class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.references :counter, :null => false
      t.references :move, :null => false
      t.references :node, :null => false
      t.text :explanation
      
      t.timestamps
    end
  end
end
