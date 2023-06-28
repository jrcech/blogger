# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Update comments', type: :system do
  let(:comment) { create(:comment) }

  before do
    sign_in_user

    comment

    visit admin_comments_path
  end

  context 'when on index' do
    before do
      find_by_id("#{comment.id}-dropdown-button").click

      click_link 'Edit'
    end

    it 'user updates an comment', js: true do
      fill_in 'Title', with: 'Test title updated'
      fill_in 'Content', with: 'Test content updated'

      select 'Test article title', from: 'Article'

      click_button 'Update Comment'

      expect_updated_item
    end

    it 'user failed to update an comment', js: true do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      select '', from: 'Article'

      click_button 'Update Comment'

      expect_not_updated_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{comment.id}-dropdown-button").click
      click_link 'Show'

      find_by_id("show-#{comment.id}-dropdown-button").click
      click_link 'Edit'
    end

    it 'user updates an comment', js: true do
      fill_in 'Title', with: 'Test title updated'
      fill_in 'Content', with: 'Test content updated'

      click_button 'Update Comment'

      expect_updated_item
    end

    it 'user failed to update an comment', js: true do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''

      click_button 'Update Comment'

      expect_not_updated_item
    end
  end

  private

  def expect_updated_item
    aggregate_failures do
      expect(page).to have_content "Comment 'Test title updated' was successfully updated."
      expect(page).to have_content 'Test title updated'
      expect(resource_updated?).to eq true
    end
  end

  def expect_not_updated_item
    aggregate_failures do
      expect(page).to have_content "Comment '' wasn't updated!"
      expect(resource_updated?).to eq false
    end
  end

  def resource_updated?
    comment.updated_at < comment.reload.updated_at
  end
end
