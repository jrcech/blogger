require 'rails_helper'

RSpec.describe ReviewPresenter, type: :presenter do
  subject(:review_presenter) { described_class.new(record: review, search_query: nil) }

  let(:review) do
    build(
      :review,
      title: 'Test review title',
      content: "#{Faker::Lorem.characters(number: 100)}test"
    )
  end

  it '#truncate_content' do
    expect(review_presenter.truncate_content).not_to include 'test'
  end

  context 'with a search query' do
    subject(:review_presenter) { described_class.new(record: review, search_query: 'test') }

    let(:review) do
      build(
        :review,
        title: 'Test review title',
        content: "#{Faker::Lorem.characters(number: 50)}test#{Faker::Lorem.characters(number: 50)}"
      )
    end

    describe '#highlight_title' do
      it 'highlights the search query in the title' do
        expect(review_presenter.highlight_title).to eq('<mark>Test</mark> review title')
      end
    end

    describe '#highlight_truncate_content' do
      it 'highlights the search query in the truncated content' do
        expect(review_presenter.highlight_truncate_content).to include('<mark>test</mark>')
      end
    end
  end
end
