# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::Buttons::Group::Component, type: :component do
  it 'has a working factory' do
    build :group
  end

  it 'renders a base group of buttons' do
    render_inline build :group

    aggregate_failures do
      expect_to_have_css_attributes
    end
  end

  it 'renders a group with a title' do
    render_inline build :group, :with_title

    expect(
      page
    ).to have_css 'div.btn-group[aria-label="Test title buttons"]'
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
    [
      'div.btn-group[role="group"]>a[href="test_path1"]',
      'div>a:nth-child(2)[href="test_path2"]',
      'div.btn-group[aria-label="Buttons group"]'
    ]
  end
end
