# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { described_class.new }

  it 'has a valid factory' do
    expect(FactoryBot.build(:comment)).to be_valid
  end
end
