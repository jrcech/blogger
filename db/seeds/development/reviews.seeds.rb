after 'development:articles' do
  1000.times do |i|
    content = +''

    Random.rand(1..6).times do
      content << "#{Faker::Lorem.paragraph(random_sentences_to_add: 15)}\n"
    end

    seed(
      Review,
      find_by: { title: "Review #{i + 1}" },
      article: Article.all.sample,
      user: User.all.sample,
      content:
    )
  end
end
