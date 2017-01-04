class AddEvidenceIdToProteins < ActiveRecord::Migration
  def change
    add_column :proteins, :evidence_id, :integer
  end
end
