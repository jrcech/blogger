# frozen_string_literal: true

FactoryBot.define do
  factory :footer, class: 'Elements::Footer::Component' do
    pagination { nil }
    left_dropdown { nil }

    initialize_with { new(**attributes) }

    trait :with_pagination do
      pagination {
        Pagy.new(count: (1..10).to_a.count)
      }

      left_dropdown do
        {
          dropdown_items: [
            { title: 'Test title 1', path: 'test_path1' },
            { title: 'Test title 2', path: 'test_path2' }
          ]
        }
      end
    end
  end
end
