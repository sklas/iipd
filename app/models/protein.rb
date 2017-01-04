class Protein < ActiveRecord::Base
    belongs_to :taxon
    belongs_to :evidence
    belongs_to :family

    has_many :protein_has_domains, foreign_key: "prot_in_dom_id" 
    has_many :domains, through: :protein_has_domains, source: :dom_in_prot

    has_many :proteins_goterms, foreign_key: "protein_id", dependent: :destroy
    has_many :goterms, through: :proteins_goterms, source: :goterm

    validates :taxon_id, presence: true
    validates :protein_accession, presence: true, uniqueness: { case_sensitive: false }
    VALID_SEQUENCE_REGEX = /.[ABCDEFGHIJKLMNOPQRSTUVWYZX*-]/
    validates :protein_sequence, format: { with: VALID_SEQUENCE_REGEX }, allow_blank: true

    def domainlist
    end

    # make the relationship of protein and domain
    def add_to_protein(domain_id, startpos, endpos, evalue)
        self.protein_has_domains.where(start_position: startpos).first_or_create! do |dom|
            dom.dom_in_prot_id  = domain_id
            dom.start_position  = startpos
            dom.end_position    = endpos
            dom.evalue              = evalue
        end
        
    end

    # Create evidence of protein if it is not already present
    def add_evidence!(attributes)
        self.evidence = Evidence.where(name: attributes[1]).first_or_create! 
        self.save!
    end
            
    # Create family of protein if it is not already present
    def add_family!(family_name)
        self.family = Family.where(name: family_name).first_or_create! 
        self.save!
    end

    # make relationships with goterms
    def add_goterm(go)
        goterm = Goterm.where(go_term: go[:term]).first_or_create! do |goterm|
            goterm.go_name = go[:name] unless go[:name].blank?
        end
        begin
            self.proteins_goterms.create(goterm_id: goterm.id)
        rescue
            puts "GO term #{goterm.go_term} already present in #{self.protein_accession}"
        end
    end
end
