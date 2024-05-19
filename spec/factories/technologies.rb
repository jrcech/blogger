# == Schema Information
#
# Table name: technologies
#
#  id         :uuid             not null, primary key
#  homepage   :string
#  shortcut   :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :technology do
    homepage { nil }
    shortcut { nil }
    title { Faker::ProgrammingLanguage.name }

    trait :all do
      homepage { Faker::Internet.url }
      shortcut { Faker::Lorem.word }
    end
  end
end
