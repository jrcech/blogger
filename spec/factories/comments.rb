# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    title { 'Test comment title' }
    content { 'Test comment content' }
    article

    trait :invalid do
      content { nil }
    end

    trait :updated do
      title { 'test' }
    end
  end
end
