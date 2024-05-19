# == Schema Information
#
# Table name: comments
#
#  id         :uuid             not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  scope :search_by, lambda { |query|
    where(
      'comments.title ILIKE ? OR comments.content ILIKE ?',
      "%#{query}%",
      "%#{query}%"
    )
  }

  scope :for_article, ->(article) { where(article:) }

  self.implicit_order_column = 'created_at'
end
