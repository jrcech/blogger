class CreateTechnologies < ActiveRecord::Migration[7.1]
  def change
    create_table :technologies, id: :uuid do |t|
      t.string :homepage
      t.string :shortcut
      t.string :title, null: false

      t.timestamps
    end
  end
end
