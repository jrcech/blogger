# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Reviews read', type: :system do
  let!(:review) { create :review }

  before do
    sign_in_user

    visit admin_reviews_path
  end

  context 'when on index' do
    it 'user reads an review', js: true do
      expect_index_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{review.id}-dropdown-button").click

      click_link 'Show'
    end

    it 'user reads an review', js: true do
      expect_show_item
    end
  end

  private

  def expect_index_item
    aggregate_failures do
      expect(page).to have_content review.id
      expect(page).to have_content 'MyString'
      expect(page).to have_content 'MyText'
    end
  end

  def expect_show_item
    aggregate_failures do
      expect(page).to have_content "ID: #{review.id}"
      expect(page).to have_content 'Title: MyString'
      expect(page).to have_content 'Content: MyText'
    end
  end
end
