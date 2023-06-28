# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article

  validates :title, presence: true
  validates :content, presence: true

  scope :search_by, (lambda { |query|
    where(
      'comments.title ILIKE ? OR comments.content ILIKE ?',
      "%#{query}%",
      "%#{query}%"
    )
  })

  scope :for_article, (lambda { |article|
    where(article:)
  })
end
