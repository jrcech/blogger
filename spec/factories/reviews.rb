# == Schema Information
#
# Table name: reviews
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
#  index_reviews_on_article_id  (article_id)
#  index_reviews_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :review do
    content { Faker::Lorem.paragraph }
    title { Faker::Lorem.sentence }

    article
    user
  end
end
