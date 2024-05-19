require 'rails_helper'

RSpec.describe 'Admin Reviews create' do
  let(:admin) { create(:user) }
  let(:article) { create(:article) }

  before do
    sign_in admin

    article

    visit admin_reviews_path

    click_on 'New Review'
  end

  context 'when on index' do
    it 'user creates an review', :js do
      fill_in 'Title', with: 'Test Review'
      fill_in 'Content', with: 'Test content'

      select article.title, from: 'Article'

      click_on 'Create Review'

      expect_created_item
    end

    it 'user failed to create an review', :js do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      select '', from: 'Article'

      click_on 'Create Review'

      expect_not_created_item
    end
  end

  private

  def expect_created_item
    aggregate_failures do
      expect(page).to have_content "Review 'Test Review' was successfully created"
      expect(page).to have_content 'Test Review'
      expect(Review.count).to eq 1
    end
  end

  def expect_not_created_item
    aggregate_failures do
      expect(page).to have_content "Review wasn't created!"
      expect(Review.count).to eq 0
    end
  end
end
