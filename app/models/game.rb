class Game < ActiveRecord::Base
    validates_presence_of :title, :genre, :rating, :number_of_players
end
