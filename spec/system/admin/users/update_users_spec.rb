require 'rails_helper'

RSpec.describe 'Admin Users update' do
  let(:admin) { create(:user) }
  let(:user) { create(:user) }

  before do
    sign_in admin

    user

    visit admin_users_path
  end

  context 'when on index' do
    before do
      find_by_id("#{user.id}-dropdown-button").click

      click_on 'Edit'
    end

    it 'user updates an user', :js do
      fill_in 'First name', with: 'First name updated'
      fill_in 'Last name', with: 'Last name updated'

      click_on 'Update User'

      expect_updated_item
    end

    it 'user failed to update an user', :js do
      fill_in 'Email', with: ''

      click_on 'Update User'

      expect_not_updated_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{user.id}-dropdown-button").click
      click_on 'Show'

      find_by_id("show-#{user.id}-dropdown-button").click
      click_on 'Edit'
    end

    it 'user updates an user', :js do
      fill_in 'First name', with: 'First name updated'
      fill_in 'Last name', with: 'Last name updated'

      click_on 'Update User'

      expect_updated_item
    end

    it 'user failed to update an user', :js do
      fill_in 'Email', with: ''

      click_on 'Update User'

      expect_not_updated_item
    end
  end

  private

  def expect_updated_item
    aggregate_failures do
      expect(page).to have_content "User '#{user.email}' was successfully updated."
      expect(page).to have_content 'First name updated'
      expect(page).to have_content 'Last name updated'
      expect(resource_updated?).to be true
    end
  end

  def expect_not_updated_item
    aggregate_failures do
      expect(page).to have_content "User '' wasn't updated!"
      expect(resource_updated?).to be false
    end
  end

  def resource_updated?
    user.updated_at < user.reload.updated_at
  end
end
