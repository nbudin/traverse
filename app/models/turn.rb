class Turn < ActiveRecord::Base
  belongs_to :playthrough
  belongs_to :move
  belongs_to :play_counter
  
  validates_presence_of :playthrough, :move, :play_counter
  validate :check_possible
  before_create :execute!
  
  private
  def execute!
    move.execute!(play_counter)
  end
  
  def check_possible
    move.check_possible(play_counter, errors)
  end
end
