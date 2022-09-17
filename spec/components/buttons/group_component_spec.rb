# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Buttons::GroupComponent, type: :component do
  it 'has a working factory' do
    build :group
  end

  it 'renders a base group of buttons' do
    render_inline build :group

    aggregate_failures do
      expect_to_have_css_attributes base_button_group_css
    end
  end

  it 'renders a group with a title' do
    render_inline build :group, :with_title

    expect(
      page
    ).to have_css 'div.btn-group[aria-label="Test title buttons"]'
  end

  private

  def base_button_group_css
    [
      'div.btn-group[role="group"]>a[href="test_path1"]',
      'div>a:nth-child(2)[href="test_path2"]',
      'div.btn-group[aria-label="Buttons group"]'
    ]
  end
end
