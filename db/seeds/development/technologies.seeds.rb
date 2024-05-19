after 'development:articles' do
  100.times do |i|
    seed(
      Technology,
      find_by: { title: "Technology #{i + 1}" },
      homepage: Faker::Internet.url,
      shortcut: Faker::Lorem.word
    )
  end
end
