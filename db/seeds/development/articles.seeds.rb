after 'development:users' do
  100.times do |i|
    user = User.all.sample
    content = +''

    Random.rand(1..6).times do
      content << "#{Faker::Lorem.paragraph(random_sentences_to_add: 15)}\n"
    end

    attrs = {
      content:,
      user:
    }

    seed Article, find_by: { title: "Article #{i + 1}" }, **attrs
  end
end
