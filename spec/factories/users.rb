# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  auth_token      :string
#  email           :string           not null
#  first_name      :string
#  last_name       :string
#  password_digest :string           not null
#  user_name       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    auth_token { nil }
    email { Faker::Internet.email }
    first_name { nil }
    last_name { nil }
    password { Faker::Internet.password(min_length: 8) }
    user_name { nil }

    trait :all do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      user_name { Faker::Internet.username(specifier: 5..8) }
      auth_token { Faker::Alphanumeric.alphanumeric(number: 32) }
    end
  end
end
