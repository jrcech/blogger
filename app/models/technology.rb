# == Schema Information
#
# Table name: technologies
#
#  id         :uuid             not null, primary key
#  homepage   :string
#  shortcut   :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Technology < ApplicationRecord
  has_many :technology_assignments, dependent: :destroy
  has_many :articles, through: :technology_assignments

  validates :title, presence: true

  scope :search_by, lambda { |query|
    where(
      'technologies.title ILIKE ? OR technologies.shortcut ILIKE ?',
      "%#{query}%",
      "%#{query}%"
    )
  }

  scope :for_article, ->(article) { includes(:technology_assignments).where(technology_assignments: { article: }) }

  self.implicit_order_column = 'created_at'
end
