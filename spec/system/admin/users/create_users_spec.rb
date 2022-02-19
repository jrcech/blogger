# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Articles create', type: :system do
  before do
    resource_for :articles, :admin
    sign_in_user
    visit admin_articles_path

    click_link 'New Article'
  end

  context 'when on index' do
    it 'user creates an article', js: true do
      fill_in 'Title', with: 'Test Article'
      fill_in 'Content', with: 'Test content'

      click_button 'Create Article'

      expect_created_item
    end

    it 'user failed to create an article', js: true do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      click_button 'Create Article'

      expect_not_created_item
    end
  end

  private

  def expect_created_item
    aggregate_failures do
      expect(page).to have_content 'Article was successfully created'
      expect(page).to have_content 'Test Article'
      expect(model.count).to eq 1
    end
  end

  def expect_not_created_item
    aggregate_failures do
      expect(page).to have_content "Article wasn't created!"
      expect(model.count).to eq 0
    end
  end
end
