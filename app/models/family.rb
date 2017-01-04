class Family < ActiveRecord::Base
    has_many :proteins
    validates :name, presence: true, uniqueness: true
end
