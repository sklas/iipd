class ProteinHasDomain < ActiveRecord::Base
    belongs_to :dom_in_prot, class_name: "Domain"
    belongs_to :prot_in_dom, class_name: "Protein"
end
