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
class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password
  has_secure_token :auth_token

  validates :email, presence: true, uniqueness: true
  normalizes :email, with: ->(email) { email.strip.downcase }

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  scope :search_by, lambda { |query|
    where(
      'users.email ILIKE ? OR users.first_name ILIKE ? OR users.last_name ILIKE ?',
      "%#{query}%",
      "%#{query}%",
      "%#{query}%"
    )
  }

  self.implicit_order_column = 'created_at'

  alias_attribute :title, :email
end
