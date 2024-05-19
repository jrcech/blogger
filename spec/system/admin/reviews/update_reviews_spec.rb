require 'rails_helper'

RSpec.describe 'Update reviews' do
  let(:admin) { create(:user) }
  let(:review) { create(:review) }

  before do
    sign_in admin

    review

    visit admin_reviews_path
  end

  context 'when on index' do
    before do
      find_by_id("#{review.id}-dropdown-button").click

      click_on 'Edit'
    end

    it 'user updates an review', :js do
      fill_in 'Title', with: 'Test title updated'
      fill_in 'Content', with: 'Test content updated'

      select review.article.title, from: 'Article'

      click_on 'Update Review'

      expect_updated_item
    end

    it 'user failed to update an review', :js do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      select '', from: 'Article'

      click_on 'Update Review'

      expect_not_updated_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{review.id}-dropdown-button").click
      click_on 'Show'

      find_by_id("show-#{review.id}-dropdown-button").click
      click_on 'Edit'
    end

    it 'user updates an review', :js do
      fill_in 'Title', with: 'Test title updated'
      fill_in 'Content', with: 'Test content updated'

      click_on 'Update Review'

      expect_updated_item
    end

    it 'user failed to update an review', :js do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      click_on 'Update Review'

      expect_not_updated_item
    end
  end

  private

  def expect_updated_item
    aggregate_failures do
      expect(page).to have_content "Review 'Test title updated' was successfully updated."
      expect(page).to have_content 'Test title updated'
      expect(resource_updated?).to be true
    end
  end

  def expect_not_updated_item
    aggregate_failures do
      expect(page).to have_content "Review '' wasn't updated!"
      expect(resource_updated?).to be false
    end
  end

  def resource_updated?
    review.updated_at < review.reload.updated_at
  end
end
