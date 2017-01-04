class TaxaController < ApplicationController
    def index
      respond_to do |format|
          format.html
          format.json { render json: TaxaDatatable.new(view_context) }
      end
    end

    def show
        @taxon = Taxon.find(params[:id])
        @proteins = @taxon.proteins
          respond_to do |format|
              format.html
              format.json { render json: TaxonProteinsDatatable.new(view_context) }
          end
    end
end
