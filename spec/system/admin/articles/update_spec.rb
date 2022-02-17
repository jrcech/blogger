# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Articles update', type: :system do
  let!(:factory) { create :article }

  before do
    sign_in_user

    visit admin_articles_path
  end

  context 'when on index' do
    before do
      find_by_id("#{factory.id}-dropdown-button").click

      click_link 'Edit'
    end

    it 'user updates an article', js: true do
      fill_in 'Title', with: 'Test title updated'
      fill_in 'Content', with: 'Test content updated'

      click_button 'Update Article'

      expect_updated_item
    end

    it 'user failed to update an article from show', js: true do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      click_button 'Update Article'

      expect_not_created_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{factory.id}-dropdown-button").click
      click_link 'Show'

      click_link 'Edit'
    end

    it 'user updates an article', js: true do
      fill_in 'Title', with: 'Test title updated'
      fill_in 'Content', with: 'Test content updated'

      click_button 'Update Article'

      expect_updated_item
    end

    it 'user failed to update an article', js: true do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      click_button 'Update Article'

      expect_not_created_item
    end
  end

  private

  def expect_updated_item
    aggregate_failures do
      expect(page).to have_content 'Article was successfully updated.'
      expect(page).to have_content 'Test title updated'
      expect(resource_updated?).to eq true
    end
  end

  def expect_not_created_item
    aggregate_failures do
      expect(page).to have_content "Article wasn't updated!"
      expect(resource_updated?).to eq false
    end
  end

  def resource_updated?
    factory.updated_at < factory.reload.updated_at
  end
end
