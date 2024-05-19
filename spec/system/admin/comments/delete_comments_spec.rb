require 'rails_helper'

RSpec.describe 'Admin Comments destroy' do
  let(:admin) { create(:user) }
  let(:comment) { create(:comment) }

  before do
    sign_in admin

    comment

    visit admin_comments_path
  end

  context 'when on index' do
    it 'user destroyed an comment', :js do
      find_by_id("#{comment.id}-dropdown-button").click

      accept_confirm { click_on 'Destroy' }

      expect_deleted_item
    end
  end

  context 'when on show' do
    it 'user destroyed an comment', :js do
      find_by_id("#{comment.id}-dropdown-button").click
      click_on 'Show'

      find_by_id("show-#{comment.id}-dropdown-button").click
      accept_confirm { click_on 'Destroy' }

      expect_deleted_item
    end
  end

  private

  def expect_deleted_item
    aggregate_failures do
      expect(page).to have_content "Comment '#{comment.title}' was successfully destroyed."
      expect(Comment.count).to eq 0
    end
  end
end
