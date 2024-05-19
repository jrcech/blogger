require 'rails_helper'

RSpec.describe 'Admin Articles search' do
  let(:admin) { create(:user) }
  let(:article) { create(:article, title: 'Test article title', content: 'Test article content') }

  before do
    sign_in admin

    visit admin_articles_path
  end

  context 'when on index' do
    it 'user searched an article by title (exact case)', :js do
      article

      fill_in 'search_query', with: 'Test article title'
      click_on 'Search submit'

      expect_article_by_title
    end

    it 'user searched an article by title (low case)', :js do
      article

      fill_in 'search_query', with: 'test article title'
      click_on 'Search submit'

      expect_article_by_title
    end

    it 'user searched an article by title (first half of a word)', :js do
      article

      fill_in 'search_query', with: 'art'
      click_on 'Search submit'

      expect_article_by_title
    end

    it 'user searched an article by title (second half of a word)', :js do
      article

      fill_in 'search_query', with: 'icle'
      click_on 'Search submit'

      expect_article_by_title
    end

    it 'user searched an article by content (low case)', :js do
      article

      fill_in 'search_query', with: 'test article content'
      click_on 'Search submit'

      expect_article_by_content
    end

    it 'user failed to search an article', :js do
      article

      fill_in 'search_query', with: 'Wrong search'
      click_on 'Search submit'

      expect_no_article
    end
  end

  private

  def expect_article_by_title
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(1) > mark'
      expect(page).to have_content 'Test article title'
      expect(Article.count).to be 1
    end
  end

  def expect_article_by_content
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(2) > mark'
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
