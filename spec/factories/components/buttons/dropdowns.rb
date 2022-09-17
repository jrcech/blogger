# frozen_string_literal: true

FactoryBot.define do
  factory :dropdown, class: 'Buttons::DropdownComponent' do
    dropdown_items do
      [
        { title: 'Test title 1', path: 'test_path1' },
        { title: 'Test title 2', path: 'test_path2' }
      ]
    end

    item { nil }
    dropdown { {} }

    initialize_with {
      new(
        dropdown_items: dropdown_items,
        item: item,
        **dropdown
      )
    }

    trait :with_title do
      dropdown do
        {
          title: 'Test title'
        }
      end
    end

    trait :nav_item do
      dropdown do
        {
          kind: :nav_item
        }
      end
    end
  end
end
