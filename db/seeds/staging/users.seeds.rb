after :admins do
  30.times do |i|
    attrs = {
      password: Faker::Internet.password(min_length: 8, max_length: 32),
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      user_name: Faker::Internet.username(specifier: 5..8)
    }

    seed User, find_by: { email: "user.#{i + 1}@example.com" }, **attrs
  end
end
