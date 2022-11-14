# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Update reviews', type: :system do
  let(:review) { create(:review) }

  before do
    sign_in_user

    review

    visit admin_reviews_path
  end

  context 'when on index' do
    before do
      find_by_id("#{review.id}-dropdown-button").click

      click_link 'Edit'
    end

    it 'user updates an review', js: true do
      fill_in 'Title', with: 'Test title updated'
      fill_in 'Content', with: 'Test content updated'

      select 'Test article title', from: 'Article'

      click_button 'Update Review'

      expect_updated_item
    end

    it 'user failed to update an review', js: true do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      select '', from: 'Article'

      click_button 'Update Review'

      expect_not_updated_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{review.id}-dropdown-button").click
      click_link 'Show'

      find_by_id("show-#{review.id}-dropdown-button").click
      click_link 'Edit'
    end

    it 'user updates an review', js: true do
      fill_in 'Title', with: 'Test title updated'
      fill_in 'Content', with: 'Test content updated'

      click_button 'Update Review'

      expect_updated_item
    end

    it 'user failed to update an review', js: true do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      click_button 'Update Review'

      expect_not_updated_item
    end
  end

  private

  def expect_updated_item
    aggregate_failures do
      expect(page).to have_content "Review 'Test title updated' was successfully updated."
      expect(page).to have_content 'Test title updated'
      expect(resource_updated?).to eq true
    end
  end

  def expect_not_updated_item
    aggregate_failures do
      expect(page).to have_content "Review '' wasn't updated!"
      expect(resource_updated?).to eq false
    end
  end

  def resource_updated?
    review.updated_at < review.reload.updated_at
  end
end
