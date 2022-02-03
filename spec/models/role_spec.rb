# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  subject(:role) { described_class.new }

  it 'has a valid factory' do
    expect(FactoryBot.build(:role)).to be_valid
  end
end
