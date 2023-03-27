# frozen_string_literal: true

after :admins do
  puts 'Seeding Articles'

  100.times do |i|
    content = +''

    Random.rand(1..6).times do
      content << "#{Faker::Lorem.paragraph(random_sentences_to_add: 15)}\n"
    end

    seed(
      Article,
      find_by: { title: "Article #{i + 1}" },
      content:
    )
  end

  puts
end
