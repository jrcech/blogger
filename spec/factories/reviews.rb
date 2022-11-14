# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    title { 'Test review title' }
    content { 'Test review content' }
    article
  end

  trait :invalid do
    content { nil }
  end

  trait :updated do
    title { 'test' }
  end
end
