class SearchController < ApplicationController
  def blast
      if request.post?
          if params[:sequence].empty?
              flash.now[:danger] = "Sequence can't be blank;"
          end
          if params[:evalue].to_f >1 || params[:evalue].to_f <= 0
              flash.now[:danger] = "#{flash[:danger]}E-value must be between 0 and 1;"
          end
          if flash.any?
              return
          end

          @results = {}

          hit = Struct.new(:score, :evalue, :alignments, :length)
          alignment = Struct.new(:score, :evalue, :length, :identities, :positives, :gaps, :sequence)


          filename = "blast/#{Time.now.to_i}_#{rand(99999)}"
          input_file = "public/#{filename}.fasta"
          output_file = "public/#{filename}.blastout"

          File.open(input_file, 'w') do |file|
              file.write(">query\n")
              file.write(params[:sequence])
          end
          
          if params[:program] = "blastp"
              system "./blast/bin/blastp", "-query", input_file, "-db", "blast_db/immunedb", "-evalue", params[:evalue].to_f.to_s, "-out", output_file
          elsif params[:program] = "blastx"
              system "./blast/bin/blastx", "-query", input_file, "-db", "blast_db/immunedb", "-evalue", params[:evalue].to_f.to_s, "-out", output_file
          end

          File.delete(input_file)
          File.open(output_file) do |file|
              header = false
              body = true
              accession = ""
              get_seq = false
              while(line = file.gets)
                  if line.starts_with?("Sequences producing")
                      header = true
                  elsif header
                      if body
                          attributes =line.split
                          if line.split.length == 3
                              accession = attributes[0]
                              score = attributes[1]
                              evalue = attributes[2]
                              @results[accession] = hit.new(score, evalue, [])
                          end
                      end
                      if line.starts_with?(">")
                          body = false
                          get_seq = false
                          accession = line.split[1]
                          count = 0
                      end
                      if not body
                          if line.starts_with?("Length")
                              @results[accession].length = line.split("=")[1]

                          elsif line.starts_with?(" Score")
                              line = line.split("=")
                              @results[accession].alignments.push(alignment.new(line[1].split("bits")[0].to_i, 
                                                                                line[2].split(",")[0].to_f))

                          elsif line.starts_with?(" Identities")
                              line = line.split("/")
                              @results[accession].alignments[count].length = line[1].split[0]
                              @results[accession].alignments[count].identities = line[0].split[-1]
                              @results[accession].alignments[count].positives = line[1].split[-1]
                              @results[accession].alignments[count].gaps = line[2].split[-1]
                              @results[accession].alignments[count].sequence = []
                                                                                #line.split("/")[1].split[-1], 
                                                                                #line.split("/")[2].split[-1], 
                                                                                #[]))
                                  get_seq = true
                                  count += 1
                          elsif get_seq
                              @results[accession].alignments[count-1].sequence.push(line)
                          end
                      end

                  end
              end
          end
          @outfile = filename+".blastout"
          @results = @results.first(250)




             


       #   end
        

      end
  end


  def blast_results
  end

  def domains
  end
end
