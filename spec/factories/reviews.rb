FactoryBot.define do
  factory :review do
    title { "MyString" }
    content { "MyText" }
    article
  end

  trait :invalid do
    content { nil }
  end

  trait :updated do
    title { 'test' }
  end
end
