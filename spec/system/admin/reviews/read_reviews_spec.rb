require 'rails_helper'

RSpec.describe 'Admin Reviews read' do
  let(:admin) { create(:user) }
  let(:review) { create(:review) }

  before do
    sign_in admin

    review

    visit admin_reviews_path
  end

  context 'when on index' do
    it 'user reads an review', :js do
      expect_index_item
    end
  end

  context 'when on show' do
    before do
      find_by_id("#{review.id}-dropdown-button").click

      click_on 'Show'
    end

    it 'user reads an review', :js do
      expect_show_item
    end
  end

  private

  def expect_index_item
    aggregate_failures do
      expect(page).to have_content review.title
      expect(page).to have_content review.content
    end
  end

  def expect_show_item
    aggregate_failures do
      expect(page).to have_content "ID: #{review.id}"
      expect(page).to have_content "Title: #{review.title}"
      expect(page).to have_content "Content: #{review.content}"
    end
  end
end
