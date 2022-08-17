# frozen_string_literal: true

FactoryBot.define do
  factory :button, class: 'Elements::Buttons::Button::Component' do
    button { { path: 'test_path' } }
    type { nil }
    item { nil }

    initialize_with { new button: button, type: type, item: item }

    trait :full do
      button do
        {
          action: :test_action,
          aria_expanded: true,
          class: 'test',
          data: {
            title: 'Test data title',
            confirm: 'Test data confirm',
            commit: 'Test data commit',
            cancel: 'Test data cancel'
          },
          icon: 'check',
          id: 'TestId',
          method: :test_method,
          path: 'test_path',
          title: 'Test title'
        }
      end
    end

    trait :dropdown_item do
      type { :dropdown_item }
    end

    trait :dropdown_item_with_icon do
      button { { path: 'test_path', icon: 'check', title: 'Title' } }
      type { :dropdown_item }
    end

    trait :nav_item do
      type { :nav_item }
    end

    trait :divider do
      button { :divider }
    end

    trait :bootstrap do
      button { { path: 'test_path', action: :new } }
    end
  end
end
