class Node < ActiveRecord::Base
  belongs_to :game
  has_many :exits, :class_name => "Move", :foreign_key => "from_node_id", :inverse_of => :from_node
  has_many :entrances, :class_name => "Move", :foreign_key => "to_node_id", :inverse_of => :to_node
  
  validates_presence_of :game, :name
  
  def as_json(options=nil)
    super(:include => :exits)
  end
end
