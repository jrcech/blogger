require 'rails_helper'

RSpec.describe 'Admin Articles create' do
  let(:admin) { create(:user) }

  before do
    sign_in admin
    visit admin_articles_path

    click_on 'New Article'
  end

  context 'when on index' do
    it 'user creates an article', :js do
      fill_in 'Title', with: 'Test Article'
      fill_in 'Content', with: 'Test content'

      click_on 'Create Article'

      expect_created_item
    end

    it 'user failed to create an article', :js do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      click_on 'Create Article'

      expect_not_created_item
    end
  end

  private

  def expect_created_item
    aggregate_failures do
      expect(page).to have_content "Article 'Test Article' was successfully created"
      expect(page).to have_content 'Test Article'
      expect(Article.count).to eq 1
    end
  end

  def expect_not_created_item
    aggregate_failures do
      expect(page).to have_content "Article wasn't created!"
      expect(Article.count).to eq 0
    end
  end
end
