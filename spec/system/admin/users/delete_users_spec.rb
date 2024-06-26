require 'rails_helper'

RSpec.describe 'Admin Users destroy' do
  let(:admin) { create(:user) }
  let(:user) { create(:user) }

  before do
    sign_in admin

    user

    visit admin_users_path
  end

  context 'when on index' do
    it 'user destroyed an user', :js do
      find_by_id("#{user.id}-dropdown-button").click

      accept_confirm { click_on 'Destroy' }

      expect_deleted_item
    end
  end

  context 'when on show' do
    it 'user destroyed an user', :js do
      find_by_id("#{user.id}-dropdown-button").click
      click_on 'Show'

      find_by_id("show-#{user.id}-dropdown-button").click
      accept_confirm { click_on 'Destroy' }

      expect_deleted_item
    end
  end

  private

  def expect_deleted_item
    aggregate_failures do
      expect(page).to have_content "User '#{user.email}' was successfully destroyed."
      expect(User.count).to eq 1
    end
  end
end
