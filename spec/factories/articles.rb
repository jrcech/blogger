# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :article do
    title { 'MyString' }
    content { 'MyText' }
    created_at { '2019-03-08 15:33:28' }
    updated_at { '2019-03-08 15:33:28' }

    trait :invalid do
      content { nil }
    end

    trait :updated do
      title { 'test' }
    end
  end
end
