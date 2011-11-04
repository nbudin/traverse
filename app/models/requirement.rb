class Requirement < ActiveRecord::Base
  belongs_to :move, :inverse_of => :requirements
  belongs_to :counter
  belongs_to :node
  
  validates_presence_of :move, :counter, :node
  
  def check_possible(playthrough, errors)
    play_counter = playthrough.play_counter_for(counter)
    unless play_counter.current_node == node
      errors.add :base, "#{play_counter.name} is not on #{node.name}"
    end
  end
end
