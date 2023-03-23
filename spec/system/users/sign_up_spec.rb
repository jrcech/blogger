# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users Sign Up', type: :system do
  before do
    clear_emails

    visit new_user_registration_path

    fill_in 'Email', with: 'registered.user@example.com'
    fill_in 'user_password', with: '123456789'
    fill_in 'user_password_confirmation', with: '123456789'

    click_button 'Sign Up'

    wait_for_email
  end

  it 'is expected to create an unconfirmed user', js: true do
    aggregate_failures do
      expect(User.count).to eq 1
      expect(User.last.confirmed?).to be false
    end
  end

  it 'is expected to send a confirmation email', js: true do
    aggregate_failures do
      expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
      expect(Devise.mailer.deliveries.count).to eq 1
    end
  end

  context 'when user is confirmed' do
    before do
      open_email 'registered.user@example.com'

      current_email.click_link 'Confirm my account'
    end

    skip 'is expected to confirm a user', js: true do
      expect_confirmed_user
    end

    skip 'is expected to log in created user', js: true do
      visit new_user_session_path

      fill_in 'Email', with: 'registered.user@example.com'
      fill_in 'Password', with: '123456789'

      click_button 'Log In'

      expect_logged_in_user
    end
  end

  private

  def expect_confirmed_user
    aggregate_failures do
      expect(page).to have_content 'Your email address has been successfully confirmed.'
      expect(User.last.confirmed?).to be true
    end
  end

  def expect_logged_in_user
    aggregate_failures do
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_current_path root_path locale: :en
    end
  end

  def wait_for_email
    find '.toast-body', text: 'A message with a confirmation link has been sent'
  end
end
