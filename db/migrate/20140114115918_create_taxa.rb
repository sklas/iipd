class CreateTaxa < ActiveRecord::Migration
  def change
    create_table :taxa do |t|
      t.string :taxon_name
      t.integer :NCBIid
      t.text :NCBIlineage

      t.timestamps
    end
    add_index :taxa, :taxon_name
  end
end
