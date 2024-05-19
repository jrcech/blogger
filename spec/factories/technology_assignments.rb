# == Schema Information
#
# Table name: technology_assignments
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  article_id    :uuid             not null
#  technology_id :uuid             not null
#
# Indexes
#
#  index_technology_assignments_on_article_id     (article_id)
#  index_technology_assignments_on_technology_id  (technology_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (technology_id => technologies.id)
#
FactoryBot.define do
  factory :technology_assignment do
    technology
    article
  end
end
