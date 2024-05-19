require 'rails_helper'

RSpec.describe 'Admin Articles read' do
  let(:admin) { create(:user) }
  let(:article) { create(:article) }

  before do
    sign_in admin

    article

    visit admin_articles_path
  end

  context 'when on index' do
    it 'user reads an article', :js do
      expect_index_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{article.id}-dropdown-button").click

      click_on 'Show'
    end

    it 'user reads an article', :js do
      expect_show_item
    end
  end

  private

  def expect_index_item
    aggregate_failures do
      expect(page).to have_content article.title
      expect(page).to have_content article.content
    end
  end

  def expect_show_item
    aggregate_failures do
      expect(page).to have_content "ID: #{article.id}"
      expect(page).to have_content "Title: #{article.title}"
      expect(page).to have_content "Content: #{article.content}"
    end
  end
end
