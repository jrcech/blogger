# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::Buttons::Dropdown::Component, type: :component do
  it 'has a working factory' do
    build :dropdown
  end

  it 'renders a default dropdown with buttons' do
    render_inline build :dropdown

    aggregate_failures do
      expect_to_have_css_attributes
    end
  end

  it 'renders a dropdown with a title' do
    render_inline build :dropdown, :with_title

    expect(
      page
    ).to have_css 'ul[aria-labelledby="dropdown-button"]'
  end

  it 'renders a dropdown nav item' do
    render_inline build :dropdown, :nav_item

    expect(
      page
    ).to have_css 'li.nav-item.dropdown>a.nav-link.dropdown-toggle'
  end

  private

  def expect_to_have_css_attributes
    expected_attributes.each do |attribute|
      expect(
        page
      ).to have_css attribute
    end
  end

  def expected_attributes
    %w[
      div.dropdown>a.btn.btn-light
      div.dropdown>a[aria-expanded="false"]
      div.dropdown>a[data-bs-toggle="dropdown"]
      div.dropdown>ul.dropdown-menu[aria-labelledby="dropdown-button"]
      ul.dropdown-menu>li>a.dropdown-item[href="test_path1"][role="button"]
      ul.dropdown-menu>li:nth-child(2)>a.dropdown-item[href="test_path2"]
    ]
  end
end
