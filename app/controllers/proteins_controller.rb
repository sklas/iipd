class ProteinsController < ApplicationController
  def new
  end
  def index
      respond_to do |format|
          format.html
          format.json { render json: ProteinsDatatable.new(view_context) }
      end
  end

  def show
      @protein = Protein.find(params[:id])
  end
end
