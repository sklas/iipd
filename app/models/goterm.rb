class Goterm < ActiveRecord::Base
    has_many :reverse_proteins_goterms, foreign_key: "goterm_id", 
                                        class_name: "ProteinsGoterm", 
                                        dependent: :destroy

    has_many :proteins, through: :reverse_proteins_goterms, source: :protein


    validates :go_term, presence: true
end
