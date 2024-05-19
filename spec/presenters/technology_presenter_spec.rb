require 'rails_helper'

RSpec.describe TechnologyPresenter, type: :presenter do
  subject(:technology_presenter) { described_class.new(record: technology, search_query: nil) }

  let(:technology) do
    build(
      :technology,
      title: 'Test technology title',
      shortcut: 'Test Shortcut'
    )
  end

  context 'with a search query' do
    subject(:technology_presenter) { described_class.new(record: technology, search_query: 'test') }

    describe '#highlight_title' do
      it 'highlights the search query in the title' do
        expect(technology_presenter.highlight_title).to eq('<mark>Test</mark> technology title')
      end
    end

    describe '#highlight_shortcut' do
      it 'highlights the search query in the shortcut' do
        expect(technology_presenter.highlight_shortcut).to eq('<mark>Test</mark> Shortcut')
      end
    end
  end
end
