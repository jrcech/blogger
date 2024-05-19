require 'rails_helper'

RSpec.describe ArticlePresenter, type: :presenter do
  subject(:article_presenter) { described_class.new(record: article, search_query: nil) }

  let(:article) do
    build(
      :article,
      title: 'Test article title',
      content: "#{Faker::Lorem.characters(number: 100)}test"
    )
  end

  it '#truncate_content' do
    expect(article_presenter.truncate_content).not_to include 'test'
  end

  context 'with a search query' do
    subject(:article_presenter) { described_class.new(record: article, search_query: 'test') }

    let(:article) do
      build(
        :article,
        title: 'Test article title',
        content: "#{Faker::Lorem.characters(number: 50)}test#{Faker::Lorem.characters(number: 50)}"
      )
    end

    describe '#highlight_title' do
      it 'highlights the search query in the title' do
        expect(article_presenter.highlight_title).to eq('<mark>Test</mark> article title')
      end
    end

    describe '#highlight_truncate_content' do
      it 'highlights the search query in the truncated content' do
        expect(article_presenter.highlight_truncate_content).to include('<mark>test</mark>')
      end
    end
  end
end
