FactoryGirl.define do
    factory :taxon do
        sequence(:taxon_name) { |n| "Drosophila melanogaster #{n}" }
        sequence(:NCBIid) { |n| 7227+n }
        NCBIlineage             "cellular organisms; Eukaryota; Opisthokonta; Metazoa; Eumetazoa; Bilateria; Protostomia; Ecdysozoa; Panarthropoda; Arthropoda; Mandibulata; Pancrustacea; Hexapoda; Insecta; Dicondylia; Pterygota; Neoptera; Endopterygota; Diptera; Brachycera; Muscomorpha; Eremoneura; Cyclorrhapha; Schizophora; Acalyptratae; Ephydroidea; Drosophilidae; Drosophilinae; Drosophilini; Drosophilina; Drosophiliti; Drosophila; Sophophora; melanogaster group; melanogaster subgroup"
    end 

    factory :protein do 
        taxon_id 1
        sequence(:protein_accession) { |n| "Test #{n}" }
        protein_sequence  { (0...50).map { ('A'..'Z').to_a[rand(26)] }.join }
    end

    factory :domain do
        pfam_accession "PF222222"
        name "Test"
    end
end
