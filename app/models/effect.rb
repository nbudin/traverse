class Effect < ActiveRecord::Base
  belongs_to :trigger, :class_name => "Move", :inverse_of => :effects
  belongs_to :counter
  belongs_to :result, :class_name => "Move"
  
  validates_presence_of :trigger, :counter, :result
  
  def check_possible(playthrough, errors)
    result.check_possible(playthrough.play_counter_for(counter), errors)
  end
  
  def execute!(playthrough)
    play_counter = playthrough.play_counter_for(counter)
    result.execute!(play_counter)
    play_counter.save!
  end
end
