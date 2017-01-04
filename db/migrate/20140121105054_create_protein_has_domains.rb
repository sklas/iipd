class CreateProteinHasDomains < ActiveRecord::Migration
  def change
    create_table :protein_has_domains do |t|
      t.integer :dom_in_prot_id
      t.integer :prot_in_dom_id
      t.integer :start_position
      t.integer :end_position
      t.float   :evalue

      t.timestamps
    end
    add_index :protein_has_domains, :dom_in_prot_id
    add_index :protein_has_domains, :prot_in_dom_id
    add_index :protein_has_domains, [:prot_in_dom_id, :start_position], unique: true

  end
end
