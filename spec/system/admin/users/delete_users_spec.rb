# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Users destroy', type: :system do
  let(:user) { create :user }

  before do
    resource_for :users, :admin
    sign_in_user

    user

    visit admin_users_path
  end

  context 'when on index' do
    it 'user destroyed an user', js: true do
      find_by_id("#{user.id}-dropdown-button").click

      accept_confirm { click_link 'Destroy' }

      expect_deleted_item
    end
  end

  context 'when on show' do
    it 'user destroyed an user', js: true do
      find_by_id("#{user.id}-dropdown-button").click
      click_link 'Show'

      find_by_id("show-#{user.id}-dropdown-button").click
      accept_confirm { click_link 'Destroy' }

      expect_deleted_item
    end
  end

  private

  def expect_deleted_item
    aggregate_failures do
      expect(page).to have_content "User 'TestFirstName TestLastName' was successfully destroyed."
      expect(model.count).to eq 1
    end
  end
end
