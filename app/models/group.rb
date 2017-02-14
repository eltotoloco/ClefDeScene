class Group < Annonce; 
  validates :style,presence: true
    validates :avg_time, presence: true

def self.styles
    	%w(Jazz Blues Rock Classique Flamenco)
    end  
end