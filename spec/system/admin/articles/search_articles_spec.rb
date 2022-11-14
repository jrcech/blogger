# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Articles search' do
  let(:article) { create(:article) }

  before do
    sign_in_user

    visit admin_articles_path
  end

  context 'when on index' do
    it 'user searched an article by title (exact case)', js: true do
      article

      fill_in 'search_query', with: 'Test article title'
      click_button 'Search submit'

      expect_article_by_title
    end

    it 'user searched an article by title (low case)', js: true do
      article

      fill_in 'search_query', with: 'test article title'
      click_button 'Search submit'

      expect_article_by_title
    end

    it 'user searched an article by title (first half of a word)', js: true do
      article

      fill_in 'search_query', with: 'art'
      click_button 'Search submit'

      expect_article_by_title
    end

    it 'user searched an article by title (second half of a word)', js: true do
      article

      fill_in 'search_query', with: 'icle'
      click_button 'Search submit'

      expect_article_by_title
    end

    it 'user searched an article by content (low case)', js: true do
      article

      fill_in 'search_query', with: 'test article content'
      click_button 'Search submit'

      expect_article_by_content
    end

    it 'user failed to search an article', js: true do
      article

      fill_in 'search_query', with: 'Wrong search'
      click_button 'Search submit'

      expect_no_article
    end
  end

  private

  def expect_article_by_title
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(2) > mark'
      expect(page).to have_content 'Test article title'
      expect(Article.count).to be 1
    end
  end

  def expect_article_by_content
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(3) > mark'
      expect(page).to have_content 'Test article content'
      expect(Article.count).to be 1
    end
  end

  def expect_no_article
    aggregate_failures do
      expect(page).to have_content 'No items found'
      expect(Article.count).to be 1
    end
  end
end
