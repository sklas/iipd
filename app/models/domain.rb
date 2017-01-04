class Domain < ActiveRecord::Base
    has_many :reverse_protein_has_domains, foreign_key: "dom_in_prot_id",
                                           class_name: "ProteinHasDomain", dependent: :destroy
    has_many :proteins, through: :reverse_protein_has_domains, source: :prot_in_dom

    #validates :pfam_accession, presence: true
    #validates :name, presence: true


    def proteinlist

    end
end
