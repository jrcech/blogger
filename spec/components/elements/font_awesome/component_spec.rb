# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::FontAwesome::Component, type: :component do
  it 'has a working factory' do
    build :font_awesome
  end

  it 'renders a base font awesome' do
    render_inline build :font_awesome

    expect(
      page
    ).to have_css base_fontawesome_css
  end

  it 'renders a full font awesome' do
    render_inline build :font_awesome, :full

    aggregate_failures do
      expect(page).to have_text 'Test text'

      expect_to_have_css_attributes full_fontawesome_css
    end
  end

  private

  def base_fontawesome_css
    'i.fa-solid.fa-test-icon' \
      '[title="Test title"]' \
      '[data-controller="font-awesome"]'
  end

  def full_fontawesome_css
    [
      'i.fa-test-icon',
      'i.test-style',
      'i.fa-test-size',
      'i.fa-fw',
      'i.fa-test-animation',
      'i.fa-test-rotation',
      'i.fa-border',
      'i.fa-pull-test-pull',
      'i[title="Test title"]',
      'i[data-test-key="test-value"]',
      'i[data-controller="font-awesome test-controller"]'
    ]
  end
end
