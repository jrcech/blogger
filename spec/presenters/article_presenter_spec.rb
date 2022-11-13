# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlePresenter, type: :presenter do
  subject(:article_presenter) do
    described_class.new item: article, search_query: search_query
  end

  let(:article) {
    build(
      :article,
      title: 'Test Article',
      content: "#{Faker::Lorem.characters(number: 100)}test"
    )
  }

  let(:search_query) { nil }

  it 'returns a truncated content' do
    expect(article_presenter.truncate_content).not_to include 'test'
  end

  context 'with a search query' do
    let(:search_query) { 'Test' }

    it "highlights an article's title" do
      expect(
        article_presenter.highlight_title
      ).to eq '<mark>Test</mark> Article'
    end
  end
end
