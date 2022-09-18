# frozen_string_literal: true

FactoryBot.define do
  factory :dropdown, class: 'Buttons::DropdownComponent' do
    title { 'Test title' }

    dropdown_items do
      [
        { title: 'Test title 1', path: 'test_path1' },
        { title: 'Test title 2', path: 'test_path2' }
      ]
    end

    id { nil }
    float { nil }
    css_class { nil }
    icon { nil }
    data { nil }

    initialize_with { new(**attributes) }

    trait :full do
      icon { 'test-icon' }
      id { 'TestId' }
      float { 'end' }
      css_class { 'test-class' }
      data { { test_key: 'test-value' } }
    end
  end
end
