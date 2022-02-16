# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Articles', type: :system do
  let!(:factory) { create :article }

  before do
    resource_for :articles, :admin
    sign_in_user
    visit admin_articles_path
  end

  it 'user destroyed an article from index', js: true do
    find_by_id("#{factory.id}-dropdown-button").click

    accept_confirm { click_link 'Destroy' }

    expect_deleted_item
  end

  it 'user destroyed an article from show', js: true do
    find_by_id("#{factory.id}-dropdown-button").click
    click_link 'Show'

    accept_confirm { click_link 'Destroy' }

    expect_deleted_item
  end

  private

  def expect_deleted_item
    aggregate_failures do
      expect(page).to have_content 'Article was successfully destroyed.'
      expect(model.count).to eq 0
    end
  end
end
