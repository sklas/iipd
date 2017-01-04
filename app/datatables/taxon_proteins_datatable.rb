class TaxonProteinsDatatable
  delegate :params, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Taxon.find(params[:id]).proteins.count, #Taxon.find(params.proteins.count,
      iTotalDisplayRecords: proteins.total_entries,
      aaData: data
    }
  end

private

  def data
    proteins.map do |protein|
      [
        link_to(protein.protein_accession, protein),
        protein.name,
        protein.protein_sequence.length,

        # show the link only when NCBI id is present
        #if protein.taxon.NCBIid.nil?
        #    protein.taxon.taxon_name
        #else
        #    link_to(protein.taxon.taxon_name, "http://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=#{protein.taxon.NCBIid}&lvl=3&lin=f&keep=1&srchmode=1&unlock", target: "_blank", title: "More infos at NCBI Taxonomy")
        #end
        link_to(protein.taxon.taxon_name, protein.taxon)
      ]
    end
  end

  def proteins
    @proteins ||= fetch_proteins
  end

  def fetch_proteins
    proteins = Taxon.find(params[:id]).proteins.order("#{sort_column} #{sort_direction}")
    proteins = proteins.page(page).per_page(per_page)
    if params[:sSearch].present?
      searchstring = params[:sSearch]
      proteins = proteins.where{name.matches("%#{searchstring}%") | protein_accession.matches("%#{searchstring}%")}
    end
    proteins
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[protein_accession name LENGTH(protein_sequence) ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
