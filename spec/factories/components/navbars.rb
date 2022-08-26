# frozen_string_literal: true

FactoryBot.define do
  factory :navbar, class: 'Elements::Navbar::Component' do
    left_nav { nil }
    right_nav { nil }

    initialize_with { new(**attributes) }

    trait :with_left_nav do
      left_nav do
        [
          { title: 'Test title 1', path: 'test_path1' },
          { title: 'Test title 2', path: 'test_path2' }
        ]
      end
    end

    trait :with_right_nav do
      right_nav do
        [
          { title: 'Test title 3', path: 'test_path3' },
          { title: 'Test title 4', path: 'test_path4' }
        ]
      end
    end
  end
end
