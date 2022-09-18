# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Buttons::DropdownComponent, type: :component do
  it 'has a working factory' do
    build :dropdown
  end

  it 'renders a default dropdown with buttons' do
    render_inline build(:dropdown)

    aggregate_failures do
      expect_to_have_css_attributes base_dropdown_css
    end
  end

  private

  def base_dropdown_css
    [
      'div.dropdown > a.dropdown-toggle + ul.dropdown-menu',
      'a[href="#"]',
      'a[role="button"]',
      'a[aria-expanded="false"]',
      'a[data-bs-toggle="dropdown"]',
      'ul[aria-labelledby="dropdown-button"]',
      'ul.dropdown-menu > li:nth-child(2) > a.dropdown-item',
      'a.dropdown-item[role="button"]',
      'a.dropdown-item[href="test_path2"]'
    ]
  end
end
