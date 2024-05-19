require 'rails_helper'

RSpec.describe UserPresenter, type: :presenter do
  subject(:user_presenter) { described_class.new(record: user, search_query: nil) }

  let(:user) do
    build(
      :user,
      first_name: 'John',
      last_name: 'Doe',
      email: 'johndoe@example.com'
    )
  end

  describe '#full_name' do
    it 'returns the full name of the user' do
      expect(user_presenter.full_name).to eq('John Doe')
    end
  end

  context 'with a search query' do
    subject(:user_presenter) { described_class.new(record: user, search_query: 'john') }

    describe '#highlight_full_name' do
      it 'highlights the search query in the full name' do
        expect(user_presenter.highlight_full_name).to eq('<mark>John</mark> Doe')
      end
    end

    describe '#highlight_email' do
      it 'highlights the search query in the email' do
        expect(user_presenter.highlight_email).to eq('<mark>john</mark>doe@example.com')
      end
    end
  end
end
