# frozen_string_literal: true

FactoryBot.define do
  factory :footer, class: 'Elements::Footer::Component' do
    pagination { nil }

    initialize_with { new(**attributes) }

    trait :with_pagination do
      pagination {
        Pagy.new(count: (1..10).to_a.count)
      }
    end
  end
end
