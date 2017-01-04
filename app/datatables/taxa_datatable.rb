class TaxaDatatable
  delegate :params, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Taxon.count,
      iTotalDisplayRecords: taxa.total_entries,
      aaData: data
    }
  end

private

  def data
    taxa.map do |taxon|
      [
        link_to(taxon.taxon_name, taxon, data: {no_turbolink: true}),
        taxon.proteins.count,

        # show the link only when NCBI id is present
        if taxon.NCBIid.nil?
            "no NCBI taxonomy ID present"
        else
            link_to("Link", "http://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=#{taxon.NCBIid}&lvl=3&lin=f&keep=1&srchmode=1&unlock", target: "_blank", title: "More infos at NCBI Taxonomy")
        end
      ]
    end
  end

  def taxa
    @taxa ||= fetch_taxa
  end

  def fetch_taxa
    taxa = Taxon.joins(:proteins).group("taxa.id").order("#{sort_column} #{sort_direction}")
    taxa = taxa.page(page).per_page(per_page)
    if params[:sSearch].present?
      searchstring = params[:sSearch]
      taxa = taxa.where{taxon_name.matches("%#{searchstring}%")}
    end
    taxa
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[taxon_name count(proteins.id)]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
