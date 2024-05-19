require 'rails_helper'

RSpec.describe ModelPresenter do
  let(:record) { build(:user) }
  let(:presenter) { described_class.new(record:) }

  describe '#model_symbol' do
    it 'returns the underscored class name' do
      expect(presenter.model_symbol).to eq(record.class.name.underscore)
    end
  end

  describe '#model_symbol_plural' do
    it 'returns the pluralized underscored class name' do
      expect(presenter.model_symbol_plural).to eq(record.class.name.underscore.pluralize)
    end
  end
end
