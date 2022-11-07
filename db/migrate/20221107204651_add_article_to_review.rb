class AddArticleToReview < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :article, null: false, foreign_key: true
  end
end
