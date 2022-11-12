class Review < ApplicationRecord
  belongs_to :article

  validates :title, presence: true
  validates :content, presence: true

  scope :search_by, (lambda { |query|
    where(
      'reviews.title ILIKE ? OR reviews.content ILIKE ?',
      "%#{query}%",
      "%#{query}%"
    )
  })

  scope :for_article, (->(article) {
    where(article: article)
  })
end
