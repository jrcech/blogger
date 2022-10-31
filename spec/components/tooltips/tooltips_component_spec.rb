# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tooltips::TooltipComponent, type: :component do
  it 'has a working factory' do
    build :tooltip
  end

  it 'renders a base tooltip' do
    render_inline build :tooltip

    expect(
      page
    ).to have_css base_tooltip_css
  end

  it 'renders a full tooltip' do
    render_inline build :tooltip, :full

    aggregate_failures do
      expect(page).to have_text 'Tooltip test text'

      expect_to_have_css_attributes full_tooltip_css
    end
  end

  private

  def base_tooltip_css
    'i.fa-solid.fa-tooltip-test-icon' \
      '[title="Tooltip test title"]' \
      '[data-bs-target="tooltip"]' \
      '[data-controller="font-awesome"]'
  end

  def full_tooltip_css
    [
      'i + span.ms-1',
      'i.fa-tooltip-test-icon',
      'i.tooltip-test-style',
      'i.fa-tooltip-test-size',
      'i.fa-fw',
      'i.fa-tooltip-test-animation',
      'i.fa-tooltip-test-rotation',
      'i.fa-border',
      'i.fa-pull-tooltip-test-pull',
      'i[title="Tooltip test title"]',
      'i[data-bs-target="tooltip"]',
      'i[data-tooltip-test-key="tooltip-test-value"]',
      'i[data-controller="font-awesome tooltip-test-controller"]'
    ]
  end
end
