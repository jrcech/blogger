# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Articles destroy', type: :system do
  let!(:article) { create :article }

  before do
    resource_for :articles, :admin
    sign_in_user

    visit admin_articles_path
  end

  context 'when on index' do
    it 'user destroyed an article', js: true do
      find_by_id("#{article.id}-dropdown-button").click

      accept_confirm { click_link 'Destroy' }

      expect_deleted_item
    end
  end

  context 'when on show' do
    it 'user destroyed an article', js: true do
      find_by_id("#{article.id}-dropdown-button").click
      click_link 'Show'

      accept_confirm { click_link 'Destroy' }

      expect_deleted_item
    end
  end

  private

  def expect_deleted_item
    aggregate_failures do
      expect(page).to have_content "Article 'MyString' was successfully destroyed."
      expect(model.count).to eq 0
    end
  end
end
