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

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :assign_default_role

  rolify
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :trackable,
    :confirmable,
    :lockable,
    :omniauthable,
    omniauth_providers: %i[facebook google]
  )

  scope :search_by, (lambda { |query|
    where(
      'users.email ILIKE ? OR users.first_name ILIKE ? OR users.last_name ILIKE ?',
      "%#{query}%",
      "%#{query}%",
      "%#{query}%"
    )
  })

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      process_user(user, auth)
      user.skip_confirmation!
    end
  end

  def self.process_user(user, auth)
    info = auth.info

    user.email = info.email
    user.password = Devise.friendly_token[0, 20]
    user.first_name = info.first_name
    user.last_name = info.last_name
  end

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def role
    return :owner if has_cached_role? :owner
    return :admin if has_cached_role? :admin

    :member
  end

  def to_role
    return nil if role == :owner
    return :member if role == :admin

    :admin
  end

  def make_member
    remove_role :admin if role == :admin
  end

  def make_admin
    add_role :admin if role == :member
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end
