class CreateProteinsGoterms < ActiveRecord::Migration
  def change
    create_table :proteins_goterms do |t|
      t.integer :protein_id
      t.integer :goterm_id

      t.timestamps
    end
    add_index :proteins_goterms, [:protein_id, :goterm_id], unique: true
  end
end
