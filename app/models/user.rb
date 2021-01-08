class User < ActiveRecord::Base
    has_many :games, uniqueness: true
    has_secure_password

    validates :username, presence: true, uniqueness: true
    
end
