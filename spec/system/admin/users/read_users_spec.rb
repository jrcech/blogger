require 'rails_helper'

RSpec.describe 'Admin Users read' do
  let(:admin) { create(:user) }
  let(:user) { create(:user, :all) }

  before do
    sign_in admin

    user

    visit admin_users_path
  end

  context 'when on index' do
    it 'user reads an user', :js do
      expect_index_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{user.id}-dropdown-button").click

      click_on 'Show'
    end

    it 'user reads an user', :js do
      expect_show_item
    end
  end

  private

  def expect_index_item
    aggregate_failures do
      expect(page).to have_content user.email
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
    end
  end

  def expect_show_item
    aggregate_failures do
      expect(page).to have_content "ID: #{user.id}"
      expect(page).to have_content "E-Mail: #{user.email}"
      expect(page).to have_content "First Name: #{user.first_name}"
      expect(page).to have_content "Last Name: #{user.last_name}"
      expect(page).to have_content "User Name: #{user.user_name}"
    end
  end
end
