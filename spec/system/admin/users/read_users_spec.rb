# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Users read', type: :system do
  let!(:user) { create :user }

  before do
    sign_in_user

    visit admin_users_path
  end

  context 'when on index' do
    it 'user reads an user', js: true do
      expect_index_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{user.id}-dropdown-button").click

      click_link 'Show'
    end

    it 'user reads an user', js: true do
      expect_show_item
    end
  end

  private

  def index_expectations
    [
      user.id,
      'MyString MyString',
      user.email,
      'Member'
    ]
  end

  def show_expectations
    [
      "ID: #{user.id}",
      "E-Mail: #{user.email}",
      'First Name: MyString',
      'Last Name: MyString',
      "Username: #{user.username}"
    ]
  end

  def expect_index_item
    aggregate_failures do
      index_expectations.each do |expectation|
        expect(page).to have_content expectation
      end

      expect(page).to have_content index_expectations.join ' '
    end
  end

  def expect_show_item
    aggregate_failures do
      show_expectations.each do |expectation|
        expect(page).to have_content expectation
      end

      expect(page).to have_content show_expectations.join "\n"
    end
  end
end
