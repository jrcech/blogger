class CreateArticle < ActiveRecord::Migration[7.1]
  def change
    create_table :articles, id: :uuid do |t|
      t.text :content, null: false
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
