# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Article do
  subject(:article) { described_class.new }

  it 'has a valid factory' do
    expect(build(:article)).to be_valid
  end

  it 'is valid with valid attributes' do
    article.title = 'Test title'
    article.content = 'Test content'
    expect(article).to be_valid
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :content }
end
