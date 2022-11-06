# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  subject(:review) { described_class.new }

  it 'has a valid factory' do
    expect(FactoryBot.build(:review)).to be_valid
  end

  it 'is valid with valid attributes' do
    review.title = 'Test title'
    review.content = 'Test content'
    expect(review).to be_valid
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :content }
end
