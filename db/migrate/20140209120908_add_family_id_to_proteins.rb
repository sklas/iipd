class AddFamilyIdToProteins < ActiveRecord::Migration
  def change
    add_column :proteins, :family_id, :int
  end
end
