class PlayCounter < ActiveRecord::Base
  belongs_to :counter
  belongs_to :playthrough, :inverse_of => :play_counters
  belongs_to :current_node, :class_name => "Node"
  
  validates_presence_of :counter, :playthrough, :current_node
  
  delegate :name, :to => :counter
  delegate :exits, :to => :current_node
  
  before_validation :on => :create do
    self.current_node ||= counter.start_node
  end
  
  def possible_exits
    exits.select do |exit| 
      exit.possible?(self)
    end
  end
end
