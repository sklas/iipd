require 'net/http'
namespace :data do 
    desc "Fill database with data from file"
    task :import, [:file] => :environment do |t, args|
        # load the file and read lines
        file = File.open(args.file)
        puts t
        puts "load file #{args.file}"
        file.each do |line|

            # attributes should be:
            # 1. Protein accession
            # 2. Name
            # 3. Sequence
            # 4. Species
            attributes = line.split(",")

            if attributes.length != 4
                next
            else
                # save the taxon only if it is not already there; Probably no need to update existing ones
                tax = Taxon.where(taxon_name: attributes[3]).first_or_create! do |taxon|
                    taxon.NCBIid = fetch_ncbi_id(attributes[3])
                    taxon.NCBIlineage = taxon.NCBIid.nil? ? nil : fetch_ncbi_lineage(taxon.NCBIid)
                end 

                # Create the protein only when its not present (by protein_accession); otherwise pick it for updating
                prot = Protein.where(protein_accession: attributes[0]).first_or_create!(taxon_id: tax.id, protein_sequence: attributes[2], name: attributes[1])
            
                # This is redundant for new records, but needed for updating. Wrap in command line argument?
                prot.update!(taxon_id: tax.id, protein_sequence: attributes[2], name: attributes[1])
                

                # Create or find all domains for the protein and make a relationship to it
                domains ="" 
                puts "record #{attributes[0]} saved"
            end
        end
     end

    desc "load single files; create taxa and proteins"
    task :taxaproteins, [:file] => :environment do |t, args|
        # load taxon files for each protein
        file = File.open(args.file)
        puts t
        puts "load file #{args.file}"
        species = []
        file.each do |line|
            species.push(line.split[1..2].join(' ')).uniq!
        end
        species.each do |spec|
            #puts spec
            Taxon.where(taxon_name: spec).first_or_create! do |taxon|
                #puts taxon
                taxon.NCBIid = fetch_ncbi_id(taxon.taxon_name)
                taxon.NCBIlineage = taxon.NCBIid.nil? ? nil : fetch_ncbi_lineage(taxon.NCBIid)
                puts "rec #{spec}"
            end
        end

        file = File.open(args.file)
        file.each do |line|
            protein = line.split[0]
            species = line.split[1..2].join(' ')
            Protein.where(protein_accession: protein).first_or_create!(taxon_id: Taxon.find_by(taxon_name: species).id, protein_sequence: "")
        end

    end

    desc "load single files; sequence"
    task :sequence, [:file] => :environment do |t, args|
        file = File.open(args.file)
        puts t
        puts "load file #{args.file}"

        file = File.open(args.file)
        protein = ""
        file.each do |line|
            if line.start_with?('>')
                protein = line.split('>')[1].chomp!
            else
                Protein.find_by(protein_accession: protein).update!(protein_sequence: line)
            end
        end
    end

    desc "load single files; domains"
    task :domains, [:file] => :environment do |t, args|
        puts t
        puts "load file #{args.file}"
        file = File.open(args.file)
        protein = ""
        
        file.each do |line|

            # check if its a header line and store the name
            if line.start_with?('>')
                protein = line.split('>')[1].chomp!

            # retrieve domain information; one domain per line; save it to the db and make prot associations     
            else
                attributes = line.split
                startpoint = attributes[0]
                endpoint = attributes[1]
                pfam_id = attributes[2]
                evalue = attributes[3]
                dom =  Domain.find_or_create_by!(pfam_id: pfam_id) do |domain|
                    pfam = { id: pfam_id }
                    fetch_pfam(pfam, false)
                    domain.pfam_id     = pfam[:id]
                    domain.pfam_acc    = pfam[:acc]
                    domain.name        = pfam[:name]
                    domain.description = pfam[:desc] 
                    domain.clan_id     = pfam[:clan_id]
                    domain.clan_acc    = pfam[:clan_acc]
                end

                #begin
                    Protein.find_by(protein_accession: protein).add_to_protein(dom.id, startpoint, endpoint, evalue)
                #rescue
                #    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{dom.id}"
                #    puts "Protein #{protein} not found"
                #    puts Protein.find_by(protein_accession: protein)
                #end
            end
        end
    end

    desc "load single files; GO terms"
    task :goterms, [:file] => :environment do |t, args|
        puts t
        puts "load file #{args.file}"
        file = File.open(args.file)
        file.each do |line|
            unless line.blank?
                attributes = line.split()
                protein = attributes[0]
                puts protein
                attributes = attributes[1..-1].join(" ").split(";")
                go = {}
                attributes.each do |goterm|
                    att = goterm.split(":")[1]
                    if att.to_i == 0
                        go = {}
                        go[:name] = att

                    else
                        go[:term] = att
                        Protein.find_by(protein_accession: protein).add_goterm(go)
                        puts "added go term #{go}"
                    end
                end
            end
        end
    end

    desc "load single files; Evidences"
    task :evidence, [:file] => :environment do |t, args|
        puts t
        puts "load file #{args.file}"
        file = File.open(args.file)
        file.each do |line|
            attributes = line.split("\t")
            Protein.find_by(protein_accession: attributes[0]).add_evidence!(attributes)
            puts Protein.find_by(protein_accession: attributes[0]).protein_accession
        end
    end


    desc "load single files; Families"
    task :family, [:file] => :environment do |t, args|
        puts t
        puts "load file #{args.file}"
        file = File.open(args.file)
        file.each do |line|
            attributes = line.split("\t")
            begin
                Protein.find_by(protein_accession: attributes[1].chomp).add_family!(attributes[0])
            rescue
                #puts Protein.find_by(protein_accession: attributes[1].chomp).protein_accession
                puts "Protein #{attributes[1]} not found"
            end
        end
    end

end


# Taxon helper methods

# Get the NCBI taxonomy id from ncbi via http request
def fetch_ncbi_id(taxon)
    uri = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=taxonomy&term=#{taxon.split().join('%20')}"
    begin
        Net::HTTP.get(URI.parse(uri)).split('<Id>')[1].split('<').first
    rescue
        puts "no record found on ncbi for #{taxon}"
    end
end

# Get the lineage from ncbi via webrequest
def fetch_ncbi_lineage(taxid)
    uri = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=taxonomy&id=#{taxid}&version=2.0"
    Net::HTTP.get(URI.parse(uri)).split("<Lineage>")[1].split("<").first
end

# Retrieve information from PFAM via http request
def fetch_pfam(pfam, second_missed=false)
    uri = "http://pfam.sanger.ac.uk/family/#{pfam[:id]}?output=xml"
    pfamxml = Net::HTTP.get(URI.parse(uri))
    begin 
        pfam[:acc] = pfamxml.split('accession="')[1].split('" id=')[0]
    rescue
        puts "Second try failed?#{second_missed}"
        unless second_missed
            puts "!!!!!!!!!!!!!!!!!!#{pfam[:id]} is a dead domain"
            begin
                pfam[:id] = pfamxml.split("</em> to <em>")[1].split("</em>")[0]
                puts "the new one is #{pfam[:id]}"
            rescue
                puts "Really nothing could be found for #{pfam[:id]}"
            end
            begin
                fetch_pfam(pfam, true)
            rescue
                puts "!!!!! no record found for #{pfam[:id]}"
            end
        end
        return
    end

    begin 
        pfam[:name] = pfamxml.split("<description>")[1].split("\n")[2]
    rescue
        puts "no name for #{pfam[:id]} found"
    end

    begin
        pfam[:desc] = pfamxml.split("<comment>")[1].split("\n")[2]
    rescue
        puts "no description for #{pfam[:id]} present"
    end
    
    begin
        pfam[:clan_id] = pfamxml.split('clan_id="')[1].split('"')[0]
        pfam[:clan_acc] = pfamxml.split('clan_acc="')[1].split('"')[0]
    rescue
        puts "no clan for #{pfam[:id]} present"
    end
end













