class Counter < ActiveRecord::Base
  belongs_to :game
  belongs_to :start_node, :class_name => "Node"
  
  validates_presence_of :game, :name
end
