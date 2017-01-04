class CreateGoterms < ActiveRecord::Migration
  def change
    create_table :goterms do |t|
      t.string :go_term
      t.string :go_name

      t.timestamps
    end
  end
end
