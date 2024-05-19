require 'rails_helper'

RSpec.describe 'Admin Users search' do
  let(:admin) { create(:user) }
  let(:user) { create(:user, email: 'test@example.com', first_name: 'John', last_name: 'Doe') }

  before do
    sign_in admin

    visit admin_users_path
  end

  context 'when on index' do
    it 'user searched an user by first name (exact case)', :js do
      user

      fill_in 'search_query', with: 'John'
      click_on 'Search submit'

      expect_user_by_name
    end

    it 'user searched an user by first name (low case)', :js do
      user

      fill_in 'search_query', with: 'john'
      click_on 'Search submit'

      expect_user_by_name
    end

    it 'user searched an user by first name (first half of a word)', :js do
      user

      fill_in 'search_query', with: 'Jo'
      click_on 'Search submit'

      expect_user_by_name
    end

    it 'user searched an user by first name (second half of a word)', :js do
      user

      fill_in 'search_query', with: 'hn'
      click_on 'Search submit'

      expect_user_by_name
    end

    it 'user searched an user by last name (low case)', :js do
      user

      fill_in 'search_query', with: 'doe'
      click_on 'Search submit'

      expect_user_by_name
    end

    it 'user searched an user by email (low case)', :js do
      user

      fill_in 'search_query', with: '@example.com'
      click_on 'Search submit'

      expect_user_by_email
    end

    it 'user failed to search an user', :js do
      user

      fill_in 'search_query', with: 'Wrong search'
      click_on 'Search submit'

      expect_no_user
    end
  end

  private

  def expect_user_by_name
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(1) > mark'
      expect(page).to have_content 'John Doe'
      expect(User.count).to be 2
    end
  end

  def expect_user_by_email
    aggregate_failures do
      expect(page).to have_css 'tr > td:nth-child(2) > mark'
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
