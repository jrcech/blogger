# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::Card::Component, type: :component do
  let(:user) {
    FactoryBot.build(
      :user,
      email: 'john.doe@example.com',
      first_name: 'John'
    )
  }

  let(:user_presenter) { UserPresenter.new item: user }

  let(:component) {
    described_class.new(
      item: user,
      item_presenter: user_presenter,
      details: %i[email first_name]
    )
  }

  before do
    render_inline(component)
  end

  it 'renders component' do
    expect(rendered_component).to have_text 'john.doe@example.com'
  end

  it 'loops through card body' do
    expect(rendered_component).to have_css 'p:nth-child(2)', text: 'John'
  end

  it 'stops looping through card body' do
    expect(rendered_component).not_to have_css 'p:nth-child(3)'
  end
end
