class ProteinsGoterm < ActiveRecord::Base
    belongs_to :protein
    belongs_to :goterm
end
