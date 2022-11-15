# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Users search' do
  let(:user) { create(:user) }

  before do
    sign_in_user

    visit admin_users_path
  end

  context 'when on index' do
    it 'user searched an user by first name (exact case)', js: true do
      user

      fill_in 'search_query', with: 'TestFirstName'
      click_button 'Search submit'

      expect_user_by_name
    end

    it 'user searched an user by first name (low case)', js: true do
      user

      fill_in 'search_query', with: 'testfirstname'
      click_button 'Search submit'

      expect_user_by_name
    end

    it 'user searched an user by first name (first half of a word)', js: true do
      user

      fill_in 'search_query', with: 'TestFirst'
      click_button 'Search submit'

      expect_user_by_name
    end

    it 'user searched an user by first name (second half of a word)', js: true do
      user

      fill_in 'search_query', with: 'FirstName'
      click_button 'Search submit'

      expect_user_by_name
    end

    it 'user searched an user by last name (low case)', js: true do
      user

      fill_in 'search_query', with: 'testlastname'
      click_button 'Search submit'

      expect_user_by_name
    end

    it 'user searched an user by email (low case)', js: true do
      user

      fill_in 'search_query', with: '@example.com'
      click_button 'Search submit'

      expect_user_by_email
    end

    it 'user failed to search an user', js: true do
      user

      fill_in 'search_query', with: 'Wrong search'
      click_button 'Search submit'

      expect_no_user
    end
  end

  private

  def expect_user_by_name
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(2) > mark'
      expect(page).to have_content 'TestFirstName'
      expect(User.count).to be 2
    end
  end

  def expect_user_by_email
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(3) > mark'
      expect(page).to have_content '@example.com'
      expect(User.count).to be 2
    end
  end

  def expect_no_user
    aggregate_failures do
      expect(page).to have_content 'No items found'
      expect(User.count).to be 2
    end
  end
end
