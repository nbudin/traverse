class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.references :game, :null => false
      t.string :name, :null => false
      t.text :description
      t.timestamps
    end
  end
end
