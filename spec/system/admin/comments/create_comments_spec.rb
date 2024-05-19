require 'rails_helper'

RSpec.describe 'Admin Comments create' do
  let(:admin) { create(:user) }
  let(:article) { create(:article) }

  before do
    sign_in admin

    article

    visit admin_comments_path

    click_on 'New Comment'
  end

  context 'when on index' do
    it 'user creates an comment', :js do
      fill_in 'Title', with: 'Test Comment'
      fill_in 'Content', with: 'Test content'

      select article.title, from: 'Article'

      click_on 'Create Comment'

      expect_created_item
    end

    it 'user failed to create an comment', :js do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      select '', from: 'Article'

      click_on 'Create Comment'

      expect_not_created_item
    end
  end

  private

  def expect_created_item
    aggregate_failures do
      expect(page).to have_content "Comment 'Test Comment' was successfully created"
      expect(page).to have_content 'Test Comment'
      expect(Comment.count).to eq 1
    end
  end

  def expect_not_created_item
    aggregate_failures do
      expect(page).to have_content "Comment wasn't created!"
      expect(Comment.count).to eq 0
    end
  end
end
