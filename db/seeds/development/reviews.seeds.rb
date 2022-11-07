# frozen_string_literal: true

after 'development:articles' do
  puts 'Seeding Reviews'

  1000.times do |i|
    article = Article.all.sample

    content = +''

    Random.rand(1..6).times do
      content << "#{Faker::Lorem.paragraph(random_sentences_to_add: 15)}\n"
    end

    attrs = {
      content: content,
      article: article
    }

    seed Review, { title: "Review #{i + 1}" }, attrs
  end

  puts
end
