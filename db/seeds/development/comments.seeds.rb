# frozen_string_literal: true

after 'development:articles' do
  puts 'Seeding Comments'

  1000.times do |i|
    content = +''

    Random.rand(1..6).times do
      content << "#{Faker::Lorem.paragraph(random_sentences_to_add: 15)}\n"
    end

    seed(
      Comment,
      find_by: { title: "Comment #{i + 1}" },
      article: Article.all.sample,
      content:
    )
  end

  puts
end
