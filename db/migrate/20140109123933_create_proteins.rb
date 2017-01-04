class CreateProteins < ActiveRecord::Migration
  def change
    create_table :proteins do |t|
      t.string :protein_accession
      t.text :protein_sequence
      t.string :name
      t.integer :taxon_id


      t.timestamps
    end

    add_index :proteins, :protein_accession, unique: true
    add_index :proteins, :name
  end
end
