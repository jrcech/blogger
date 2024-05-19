require 'rails_helper'

RSpec.describe CommentPresenter, type: :presenter do
  subject(:comment_presenter) { described_class.new(record: comment, search_query: nil) }

  let(:comment) do
    build(
      :comment,
      title: 'Test comment title',
      content: "#{Faker::Lorem.characters(number: 100)}test"
    )
  end

  it '#truncate_content' do
    expect(comment_presenter.truncate_content).not_to include 'test'
  end

  context 'with a search query' do
    subject(:comment_presenter) { described_class.new(record: comment, search_query: 'test') }

    let(:comment) do
      build(
        :comment,
        title: 'Test comment title',
        content: "#{Faker::Lorem.characters(number: 50)}test#{Faker::Lorem.characters(number: 50)}"
      )
    end

    describe '#highlight_title' do
      it 'highlights the search query in the title' do
        expect(comment_presenter.highlight_title).to eq('<mark>Test</mark> comment title')
      end
    end

    describe '#highlight_truncate_content' do
      it 'highlights the search query in the truncated content' do
        expect(comment_presenter.highlight_truncate_content).to include('<mark>test</mark>')
      end
    end
  end
end
