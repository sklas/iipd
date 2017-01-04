class CreateEvidences < ActiveRecord::Migration
  def change
    create_table :evidences do |t|
      t.string :name

      t.timestamps
    end
    add_index :evidences, :name
  end
end
