# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::Buttons::Button::Component, type: :component do
  it 'has a working factory' do
    build :button
  end

  it 'renders a base button' do
    render_inline build :button

    expect(
      page
    ).to have_css base_button_css
  end

  it 'renders a full button from a hash' do
    render_inline build :button, :full

    aggregate_failures do
      expect(page).to have_text 'Test title'

      expect_to_have_css_attributes full_button_css
    end
  end

  it 'renders a divider' do
    render_inline build :button, :divider

    expect(
      page
    ).to have_css 'hr.dropdown-divider'
  end

  it 'renders a dropdown item' do
    render_inline build :button, :dropdown_item

    expect(
      page
    ).to have_css 'li>a.dropdown-item[role="button"]'
  end

  it 'renders a dropdown item with an icon' do
    render_inline build :button, :dropdown_item_with_icon

    expect(
      page
    ).to have_css 'li>a.dropdown-item>i.fa-check.fa-fw'
  end

  it 'renders a nav item' do
    render_inline build :button, :nav_item

    expect(
      page
    ).to have_css 'li.nav-item>a.nav-link'
  end

  it 'renders with a bootstrap class' do
    render_inline build :button, :bootstrap

    expect(
      page
    ).to have_css bootstrap_button_css
  end

  private

  def base_button_css
    'a.btn.btn-primary' \
      '[role="button"]' \
      '[href="test_path"]'
  end

  def bootstrap_button_css
    'a.btn.btn-success' \
      '[role="button"]' \
      '[href="test_path"]'
  end

  def full_button_css
    [
      'i.fa-check',
      'a[aria-expanded="true"]',
      'a[class="test"]',
      'a[href="test_path"]',
      'a[id="TestId"]',
      'a[data-method="test_method"]',
      'a[data-title="Test data title"]',
      'a[data-confirm="Test data confirm"]',
      'a[data-commit="Test data commit"]',
      'a[data-cancel="Test data cancel"]',
      'a[role="button"]'
    ]
  end
end
