require 'rails_helper'

RSpec.describe 'Admin Articles destroy' do
  let(:admin) { create(:user) }
  let(:article) { create(:article) }

  before do
    sign_in admin

    article

    visit admin_articles_path
  end

  context 'when on index' do
    it 'user destroyed an article', :js do
      find_by_id("#{article.id}-dropdown-button").click

      accept_confirm { click_on 'Destroy' }

      expect_deleted_item
    end
  end

  context 'when on show' do
    it 'user destroyed an article', :js do
      find_by_id("#{article.id}-dropdown-button").click
      click_on 'Show'

      find_by_id("show-#{article.id}-dropdown-button").click
      accept_confirm { click_on 'Destroy' }

      expect_deleted_item
    end
  end

  private

  def expect_deleted_item
    aggregate_failures do
      expect(page).to have_content "Article '#{article.title}' was successfully destroyed."
      expect(Article.count).to eq 0
    end
  end
end
