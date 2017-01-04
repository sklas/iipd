class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :pfam_acc
      t.string :pfam_id
      t.string :name
      t.text   :description
      t.string :clan_id
      t.string :clan_acc

      t.timestamps
    end
    add_index :domains, :pfam_id
    add_index :domains, :clan_id
    add_index :domains, :name
  end
end
