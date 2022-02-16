# frozen_string_literal: true

after :admins do
  puts 'Seeding Users'

  30.times do |i|
    attrs = {
      password: Faker::Internet.password(min_length: 8, max_length: 32),
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      confirmed_at: DateTime.now,
      confirmation_token: Faker::Internet.password(min_length: 20, max_length: 50)
    }

    seed User, { email: "user.#{i + 1}@example.com" }, attrs
  end

  non_admins = User.where.not(email: 'jiricech94@gmail.com')

  admins = non_admins.order('RANDOM()').first(Random.rand(2..5))
  admins.each do |admin|
    admin.add_role :admin
  end

  owners = non_admins.order('RANDOM()').first(Random.rand(2..5))
  owners.each do |owner|
    owner.add_role :owner
  end

  puts
end
