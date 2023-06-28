# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment do
  subject(:comment) { described_class.new }

  let(:article) { create(:article) }

  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
  end

  it 'is valid with valid attributes' do
    comment.title = 'Test title'
    comment.content = 'Test content'
    comment.article = article

    expect(comment).to be_valid
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :content }
end
