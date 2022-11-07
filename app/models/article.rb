# frozen_string_literal: true
# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord
  has_many :reviews

  validates :title, presence: true
  validates :content, presence: true

  scope :search_by, (lambda { |query|
    where(
      'articles.title ILIKE ? OR articles.content ILIKE ?',
      "%#{query}%",
      "%#{query}%"
    )
  })
end
