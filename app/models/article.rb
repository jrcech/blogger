# == Schema Information
#
# Table name: articles
#
#  id         :uuid             not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :technology_assignments, dependent: :destroy
  has_many :technologies, through: :technology_assignments

  validates :title, presence: true
  validates :content, presence: true

  scope :search_by, lambda { |query|
    where(
      'articles.title ILIKE ? OR articles.content ILIKE ?',
      "%#{query}%",
      "%#{query}%"
    )
  }

  self.implicit_order_column = 'created_at'
end
