# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Comments search' do
  let(:comment) { create(:comment) }

  before do
    sign_in_user

    visit admin_comments_path
  end

  context 'when on index' do
    it 'user searched an comment by title (exact case)', js: true do
      comment

      fill_in 'search_query', with: 'Test comment title'
      click_button 'Search submit'

      expect_comment_by_title
    end

    it 'user searched an comment by title (low case)', js: true do
      comment

      fill_in 'search_query', with: 'test comment title'
      click_button 'Search submit'

      expect_comment_by_title
    end

    it 'user searched an comment by title (first half of a word)', js: true do
      comment

      fill_in 'search_query', with: 'com'
      click_button 'Search submit'

      expect_comment_by_title
    end

    it 'user searched an comment by title (second half of a word)', js: true do
      comment

      fill_in 'search_query', with: 'ment'
      click_button 'Search submit'

      expect_comment_by_title
    end

    it 'user searched an comment by content (low case)', js: true do
      comment

      fill_in 'search_query', with: 'test comment content'
      click_button 'Search submit'

      expect_comment_by_content
    end

    it 'user failed to search an comment', js: true do
      comment

      fill_in 'search_query', with: 'Wrong search'
      click_button 'Search submit'

      expect_no_comment
    end
  end

  private

  def expect_comment_by_title
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(2) > mark'
      expect(page).to have_content 'Test comment title'
      expect(Comment.count).to be 1
    end
  end

  def expect_comment_by_content
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(3) > mark'
      expect(page).to have_content 'Test comment content'
      expect(Comment.count).to be 1
    end
  end

  def expect_no_comment
    aggregate_failures do
      expect(page).to have_content 'No items found'
      expect(Comment.count).to be 1
    end
  end
end
