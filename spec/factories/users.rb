FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "tester.#{n}@example.com" }
    sequence(:username) { |n| "username.#{n}" }
    first_name { 'MyString' }
    last_name { 'MyString' }
    password { 'MyString' }
    sequence(:reset_password_token) { |n| "MyString.#{n}" }
    reset_password_sent_at { '2019-03-08 15:33:28' }
    remember_created_at { '2019-03-08 15:33:28' }
    sign_in_count { 1 }
    current_sign_in_at { '2019-03-08 15:33:28' }
    last_sign_in_at { '2019-03-08 15:33:28' }
    current_sign_in_ip { '' }
    last_sign_in_ip { '' }
    sequence(:confirmation_token) { |n| "MyString.#{n}" }
    confirmed_at { '2019-03-08 15:33:28' }
    confirmation_sent_at { '2019-03-08 15:33:28' }
    unconfirmed_email { 'MyString' }
    created_at { '2019-03-08 15:33:28' }
    updated_at { '2019-03-08 15:33:28' }

    trait :invalid do
      email { nil }
    end

    trait :updated do
      first_name { 'test' }
    end
  end
end
