require 'rails_helper'

RSpec.describe 'Admin Users create' do
  let(:admin) { create(:user) }

  before do
    sign_in admin
    visit admin_users_path

    click_on 'New User'
  end

  context 'when on index' do
    it 'user creates an user', :js do
      fill_in 'Email', with: 'test.user@example.com'
      fill_in 'user_password', with: 'TestPassword'
      fill_in 'user_password_confirmation', with: 'TestPassword'

      click_on 'Create User'

      expect_created_item
    end

    it 'user failed to create an user', :js do
      fill_in 'Email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''

      click_on 'Create User'

      expect_not_created_item
    end
  end

  private

  def expect_created_item
    aggregate_failures do
      expect(page).to have_content "User 'test.user@example.com' was successfully created"
      expect(User.count).to eq 2
    end
  end

  def expect_not_created_item
    aggregate_failures do
      expect(page).to have_content "User wasn't created!"
      expect(User.count).to eq 1
    end
  end
end
