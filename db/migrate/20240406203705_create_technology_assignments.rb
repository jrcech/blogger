class CreateTechnologyAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :technology_assignments, id: :uuid do |t|
      t.references :technology, null: false, foreign_key: true, type: :uuid
      t.references :article, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
