class Playthrough < ActiveRecord::Base
  belongs_to :game
  has_many :turns, :dependent => :destroy
  has_many :play_counters, :dependent => :destroy, :inverse_of => :playthrough
  
  validates_presence_of :game
  validate :require_all_counters
  
  before_validation :build_play_counters, :on => :create
  
  def play_counter_for(counter)
    play_counters.select { |pc| pc.counter == counter }.first
  end
  
  private
  def build_play_counters
    game.counters.each do |counter|
      play_counters.build(:counter => counter) unless play_counter_for(counter)
    end
  end
  
  def require_all_counters
    game.counters.each do |counter|
      errors.add :base, "No counter in play for #{counter.name}" unless play_counter_for(counter)
    end
  end
end
