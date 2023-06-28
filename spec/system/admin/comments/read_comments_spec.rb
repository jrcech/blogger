# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Comments read', type: :system do
  let(:comment) { create(:comment) }

  before do
    sign_in_user

    comment

    visit admin_comments_path
  end

  context 'when on index' do
    it 'user reads an comment', js: true do
      expect_index_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{comment.id}-dropdown-button").click

      click_link 'Show'
    end

    it 'user reads an comment', js: true do
      expect_show_item
    end
  end

  private

  def expect_index_item
    aggregate_failures do
      expect(page).to have_content comment.id
      expect(page).to have_content 'Test comment title'
      expect(page).to have_content 'Test comment content'
    end
  end

  def expect_show_item
    aggregate_failures do
      expect(page).to have_content "ID: #{comment.id}"
      expect(page).to have_content 'Title: Test comment title'
      expect(page).to have_content 'Content: Test comment content'
    end
  end
end
