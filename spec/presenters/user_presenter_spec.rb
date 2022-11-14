# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPresenter, type: :presenter do
  subject(:user_presenter) do
    described_class.new item: user, search_query:
  end

  let(:user) do
    build(
      :user,
      first_name: 'John',
      last_name: 'Doe',
      email: 'john.doe@example.com'
    )
  end

  let(:search_query) { nil }

  it "returns a user's full name as a string" do
    expect(user_presenter.full_name).to eq 'John Doe'
  end

  it "return a user's role with highest privileges" do
    user.add_role :admin

    expect(user_presenter.user_role).to eq 'Admin'
  end

  context 'with a search query' do
    let(:search_query) { 'Doe' }

    it "highlights a user's full name" do
      expect(
        user_presenter.highlight_full_name
      ).to eq 'John <mark>Doe</mark>'
    end

    it "highlights a user's email" do
      expect(
        user_presenter.highlight_email
      ).to eq 'john.<mark>doe</mark>@example.com'
    end
  end
end
