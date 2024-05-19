after 'development:articles', 'development:technologies' do
  Article.find_each do |article|
    Random.rand(1..6).times do
      seed(
        TechnologyAssignment,
        find_by: { article:, technology: Technology.all.sample }
      )
    end
  end
end
