# frozen_string_literal: true

puts 'Seeding Admins'

seed(
  User,
  find_by: { email: ENV.fetch('RAILS_ADMIN_EMAIL') },
  password: ENV.fetch('RAILS_ADMIN_PASSWORD'),
  first_name: ENV.fetch('RAILS_ADMIN_FIRST_NAME'),
  last_name: ENV.fetch('RAILS_ADMIN_LAST_NAME'),
  confirmed_at: DateTime.now,
  confirmation_token: 'Auto Confirmed'
)

puts
