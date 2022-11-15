# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  username               :string
#  provider               :string
#  uid                    :string
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "tester.#{n}@example.com" }
    sequence(:username) { |n| "username.#{n}" }
    first_name { 'TestFirstName' }
    last_name { 'TestLastName' }
    password { 'test_password' }
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
