# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::Navbar::Component, type: :component do
  it 'has a working factory' do
    build :navbar
  end

  it 'renders a base navbar' do
    puts render_inline build(:navbar)

    aggregate_failures do
      expect_to_have_css_attributes base_navbar_css
    end
  end

  private

  def base_navbar_css
    [
      'nav.navbar.navbar-expand-lg.navbar-dark.bg-dark',
      'nav.navbar > div.container > a.navbar-brand',
      'a.navbar-brand + button.navbar-toggler + div.collapse',
      'button.navbar-toggler > span.navbar-toggler-icon',
      'button.navbar-toggler[type="button"]',
      'button.navbar-toggler[data-toggle="collapse"]',
      'button.navbar-toggler[data-target="#navbarSupportedContent"]',
      'button.navbar-toggler[aria-controls="navbarSupportedContent"]',
      'button.navbar-toggler[aria-expanded="false"]',
      'button.navbar-toggler[aria-label="Toggle navigation"]',
      'div.collapse#navbarSupportedContent',
      'div.collapse > ul.navbar-nav.me-auto > li.nav-item:nth-child(2) > a.nav-link',
      'div.collapse > ul.navbar-nav > li.nav-item:nth-child(2) > a.nav-link'
    ]
  end
end
