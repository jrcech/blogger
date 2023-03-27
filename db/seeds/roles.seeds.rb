# frozen_string_literal: true

puts 'Seeding Roles'

roles = %w[user admin owner]

roles.each do |role|
  seed Role, find_by: { name: role }
end

puts
