class Move < ActiveRecord::Base
  belongs_to :from_node, :class_name => "Node", :inverse_of => :exits
  belongs_to :to_node, :class_name => "Node", :inverse_of => :entrances
  
  has_many :requirements, :inverse_of => :move
  has_many :effects, :foreign_key => "trigger_id", :inverse_of => :trigger
  
  validates_presence_of :from_node, :to_node
  
  def as_json(options=nil)
    super(:include => [:to_node, :requirements, :effects])
  end
  
  def check_possible(play_counter, errors)
    unless play_counter.current_node == from_node
      errors.add :base, "#{play_counter.name} is not on #{from_node.name}"
    end
    
    requirements.includes(:node).find_each do |req|
      req.check_possible(play_counter.playthrough, errors)
    end
    
    effects.includes(:result => [:from_node, :requirements, :effects]).find_each do |effect|
      effect.check_possible(playthrough, errors)
    end
  end
  
  def possible?(play_counter)
    errors = ActiveModel::Errors.new(self)
    check_possible(play_counter, errors)
    errors.empty?
  end
  
  def execute!(play_counter)
    transaction do
      play_counter.current_node = to_node
      play_counter.save!
      
      effects.each { |effect| effect.execute!(playthrough) }
    end
  end
end
