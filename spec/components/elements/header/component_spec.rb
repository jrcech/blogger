# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Elements::Header::Component, type: :component do
  let(:user) {
    FactoryBot.build(
      :user,
      email: 'john.doe@example.com',
      first_name: 'John'
    )
  }

  let(:component) {
    described_class.new(
      header: {
        title: user.email,
        icon: 'check'
      },
      main_header: true,
      item: user
    )
  }

  before do
    render_inline component
  end

  it 'renders component' do
    aggregate_failures do
      expect(rendered_component).to have_text 'john.doe@example.com'
      expect(rendered_component).to have_css 'h1>i.fa-check'
    end
  end
end
