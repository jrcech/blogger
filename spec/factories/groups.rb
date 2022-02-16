# frozen_string_literal: true

FactoryBot.define do
  factory :group, class: 'Elements::Buttons::Group::Component' do
    buttons do
      [
        { title: 'Test title 1', path: 'test_path1' },
        { title: 'Test title 2', path: 'test_path2' }
      ]
    end

    title { nil }
    item { nil }

    initialize_with { new buttons: buttons, title: title, item: item }

    trait :with_title do
      title { 'Test title' }
    end
  end
end
