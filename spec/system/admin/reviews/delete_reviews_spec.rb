require 'rails_helper'

RSpec.describe 'Admin Reviews destroy' do
  let(:admin) { create(:user) }
  let(:review) { create(:review) }

  before do
    sign_in admin

    review

    visit admin_reviews_path
  end

  context 'when on index' do
    it 'user destroyed an review', :js do
      find_by_id("#{review.id}-dropdown-button").click

      accept_confirm { click_on 'Destroy' }

      expect_deleted_item
    end
  end

  context 'when on show' do
    it 'user destroyed an review', :js do
      find_by_id("#{review.id}-dropdown-button").click
      click_on 'Show'

      find_by_id("show-#{review.id}-dropdown-button").click
      accept_confirm { click_on 'Destroy' }

      expect_deleted_item
    end
  end

  private

  def expect_deleted_item
    aggregate_failures do
      expect(page).to have_content "Review '#{review.title}' was successfully destroyed."
      expect(Review.count).to eq 0
    end
  end
end
