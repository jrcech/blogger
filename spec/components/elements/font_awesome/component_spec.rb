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
    ).to have_css "i.fa-solid.fa-test-icon[title='Test title'][data-controller='font-awesome']"
  end

  it 'renders a full font awesome' do
    render_inline build :font_awesome, :full

    aggregate_failures do
      expect(page).to have_text 'Test text'

      expect_to_have_css_attributes
    end
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
      'i.fa-test-icon',
      "i[title='Test title']",
      'i.test-style',
      'i.fa-test-size',
      'i.fa-fw',
      'i.fa-test-animation',
      'i.fa-test-rotation',
      'i.fa-border',
      'i.fa-pull-test-pull',
      "i[data-test-key='test-value']",
      "i[data-controller='font-awesome test-controller']"
    ]
  end
end
