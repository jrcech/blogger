# frozen_string_literal: true

after :admins do
  puts 'Seeding Reviews'

  250.times do |i|
    content = +''

    Random.rand(1..6).times do
      content << "#{Faker::Lorem.paragraph(random_sentences_to_add: 15)}\n"
    end

    attrs = {
      content: content
    }

    seed Review, { title: "Review #{i + 1}" }, attrs
  end

  puts
end
