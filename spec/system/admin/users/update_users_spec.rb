# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Users update', type: :system do
  let!(:user) { create :user }

  before do
    sign_in_user

    visit admin_users_path
  end

  context 'when on index' do
    before do
      find_by_id("#{user.id}-dropdown-button").click

      click_link 'Edit'
    end

    it 'user updates an user', js: true do
      fill_in 'First name', with: 'First name updated'
      fill_in 'Last name', with: 'Last name updated'

      click_button 'Update User'

      expect_updated_item
    end

    it 'user failed to update an user', js: true do
      fill_in 'Email', with: ''

      click_button 'Update User'

      expect_not_updated_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{user.id}-dropdown-button").click
      click_link 'Show'

      click_link 'Edit'
    end

    it 'user updates an user', js: true do
      fill_in 'First name', with: 'First name updated'
      fill_in 'Last name', with: 'Last name updated'

      click_button 'Update User'

      expect_updated_item
    end

    it 'user failed to update an user', js: true do
      fill_in 'Email', with: ''

      click_button 'Update User'

      expect_not_updated_item
    end
  end

  private

  def expect_updated_item
    aggregate_failures do
      expect(page).to have_content "User 'First name updated Last name updated' was successfully updated."
      expect(page).to have_content 'First name updated'
      expect(page).to have_content 'Last name updated'
      expect(resource_updated?).to eq true
    end
  end

  def expect_not_updated_item
    aggregate_failures do
      expect(page).to have_content "User 'MyString MyString' wasn't updated!"
      expect(resource_updated?).to eq false
    end
  end

  def resource_updated?
    user.updated_at < user.reload.updated_at
  end
end
