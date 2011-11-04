class Game < ActiveRecord::Base
  has_many :nodes, :dependent => :destroy
  has_many :counters, :dependent => :destroy
  has_many :playthroughs, :dependent => :destroy
  
  validates_presence_of :name
  
  def as_json(options=nil)
    options ||= {}
    options[:include] ||= {
      :nodes => {
        :include => {
          :exits => {
            :include => [:requirements, :effects]
          }
        }
      },
      :counters => {}
    }
    options[:except] ||= [:created_at, :updated_at]
    super(options)
  end
end
