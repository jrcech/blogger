# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Comments destroy', type: :system do
  let(:comment) { create(:comment) }

  before do
    sign_in_user

    comment

    visit admin_comments_path
  end

  context 'when on index' do
    it 'user destroyed an comment', js: true do
      find_by_id("#{comment.id}-dropdown-button").click

      accept_confirm { click_link 'Destroy' }

      expect_deleted_item
    end
  end

  context 'when on show' do
    it 'user destroyed an comment', js: true do
      find_by_id("#{comment.id}-dropdown-button").click
      click_link 'Show'

      find_by_id("show-#{comment.id}-dropdown-button").click
      accept_confirm { click_link 'Destroy' }

      expect_deleted_item
    end
  end

  private

  def expect_deleted_item
    aggregate_failures do
      expect(page).to have_content "Comment 'Test comment title' was successfully destroyed."
      expect(Comment.count).to eq 0
    end
  end
end
