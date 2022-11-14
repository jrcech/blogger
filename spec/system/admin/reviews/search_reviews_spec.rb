# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Reviews search' do
  let(:review) { create(:review) }

  before do
    sign_in_user

    visit admin_reviews_path
  end

  context 'when on index' do
    it 'user searched an review by title (exact case)', js: true do
      review

      fill_in 'search_query', with: 'Test review title'
      click_button 'Search submit'

      expect_review_by_title
    end

    it 'user searched an review by title (low case)', js: true do
      review

      fill_in 'search_query', with: 'test review title'
      click_button 'Search submit'

      expect_review_by_title
    end

    it 'user searched an review by title (first half of a word)', js: true do
      review

      fill_in 'search_query', with: 'rev'
      click_button 'Search submit'

      expect_review_by_title
    end

    it 'user searched an review by title (second half of a word)', js: true do
      review

      fill_in 'search_query', with: 'iew'
      click_button 'Search submit'

      expect_review_by_title
    end

    it 'user searched an review by content (low case)', js: true do
      review

      fill_in 'search_query', with: 'test review content'
      click_button 'Search submit'

      expect_review_by_content
    end

    it 'user failed to search an review', js: true do
      review

      fill_in 'search_query', with: 'Wrong search'
      click_button 'Search submit'

      expect_no_review
    end
  end

  private

  def expect_review_by_title
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(2) > mark'
      expect(page).to have_content 'Test review title'
      expect(Review.count).to be 1
    end
  end

  def expect_review_by_content
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(3) > mark'
      expect(page).to have_content 'Test review content'
      expect(Review.count).to be 1
    end
  end

  def expect_no_review
    aggregate_failures do
      expect(page).to have_content 'No items found'
      expect(Review.count).to be 1
    end
  end
end
