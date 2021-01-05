class Game < ActiveRecord::Base
    belongs_to :user
    
    validates_presence_of :title, :genre, :rating, :number_of_players
end
