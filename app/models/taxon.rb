class Taxon < ActiveRecord::Base
    has_many :proteins, dependent: :destroy
    validates :taxon_name, presence: true, uniqueness: true
    #validates :NCBIid, uniqueness: true
    
end
