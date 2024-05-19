require 'rails_helper'

RSpec.describe 'Admin Comments read' do
  let(:admin) { create(:user) }
  let(:comment) { create(:comment) }

  before do
    sign_in admin

    comment

    visit admin_comments_path
  end

  context 'when on index' do
    it 'user reads an comment', :js do
      expect_index_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{comment.id}-dropdown-button").click

      click_on 'Show'
    end

    it 'user reads an comment', :js do
      expect_show_item
    end
  end

  private

  def expect_index_item
    aggregate_failures do
      expect(page).to have_content comment.title
      expect(page).to have_content comment.content
    end
  end

  def expect_show_item
    aggregate_failures do
      expect(page).to have_content "ID: #{comment.id}"
      expect(page).to have_content "Title: #{comment.title}"
      expect(page).to have_content "Content: #{comment.content}"
    end
  end
end
