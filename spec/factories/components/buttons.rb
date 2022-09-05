# frozen_string_literal: true

FactoryBot.define do
  factory :button, class: 'Elements::Buttons::Button::Component' do
    title { 'Test title' }
    path { 'Test path' }

    type { nil }
    item { nil }

    action { nil }
    aria_expanded { nil }
    css_class { nil }
    data { nil }
    icon { nil }
    id { nil }
    link_method { nil }

    dropdown_items { nil }

    initialize_with { new(**attributes) }

    trait :full do
      action { :test_action }
      aria_expanded { true }
      css_class { 'test' }

      data do
        {
          title: 'Test data title',
          confirm: 'Test data confirm',
          commit: 'Test data commit',
          cancel: 'Test data cancel'
        }
      end

      icon { 'test-icon' }
      id { 'TestId' }
      link_method { :test_method }
      path { 'test_path' }
      title { 'Test title' }
    end

    trait :dropdown do
      dropdown_items do
        [
          { title: 'Test title 1', path: 'test_path1' },
          { title: 'Test title 2', path: 'test_path2' }
        ]
      end

      action { :test_action }
      aria_expanded { true }
      css_class { 'test' }

      data do
        {
          title: 'Test data title',
          confirm: 'Test data confirm',
          commit: 'Test data commit',
          cancel: 'Test data cancel'
        }
      end

      icon { 'test-icon' }
      id { 'TestId' }
      link_method { :test_method }
      path { 'test_path' }
      title { 'Test title' }
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
