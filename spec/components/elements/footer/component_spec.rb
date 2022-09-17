# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::Footer::Component, type: :component do
  it 'has a working factory' do
    build :footer
  end

  it 'renders a base footer' do
    render_inline build(:footer)

    expect(
      page
    ).to have_css base_footer_css
  end

  it 'renders a footer with left dropdown' do
    puts render_inline build(:footer, :with_left_dropdown)

    aggregate_failures do
      expect_to_have_css_attributes dropdown_footer_css
    end
  end

  it 'renders a footer with pagination' do
    puts render_inline build(:footer, :with_pagination)

    aggregate_failures do
      expect_to_have_css_attributes pagination_footer_css
    end
  end

  private

  def base_footer_css
    'footer.row > div.col-md'
  end

  def dropdown_footer_css
    [
      'footer.row > div.col-md > div.dropdown > a + ul',
      'ul.dropdown-menu > li:nth-child(2)'
    ]
  end

  def pagination_footer_css
    [
      'footer.row > div.col-md + div.col-md > nav.pagy-bootstrap-nav-js',
      'div[data-controller="pagy"]',
    ]
  end
end
