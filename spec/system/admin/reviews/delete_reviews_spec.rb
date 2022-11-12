# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Reviews destroy', type: :system do
  let(:review) { create :review }

  before do
    resource_for :reviews, :admin
    sign_in_user

    review

    visit admin_reviews_path
  end

  context 'when on index' do
    it 'user destroyed an review', js: true do
      find_by_id("#{review.id}-dropdown-button").click

      accept_confirm { click_link 'Destroy' }

      expect_deleted_item
    end
  end

  context 'when on show' do
    it 'user destroyed an review', js: true do
      find_by_id("#{review.id}-dropdown-button").click
      click_link 'Show'

      find_by_id("show-#{review.id}-dropdown-button").click
      accept_confirm { click_link 'Destroy' }

      expect_deleted_item
    end
  end

  private

  def expect_deleted_item
    aggregate_failures do
      expect(page).to have_content "Review 'MyString' was successfully destroyed."
      expect(model.count).to eq 0
    end
  end
end
