class CreateEffects < ActiveRecord::Migration
  def change
    create_table :effects do |t|
      t.references :trigger, :null => false
      t.references :counter, :null => false
      t.references :result, :null => false
      t.timestamps
    end
  end
end
