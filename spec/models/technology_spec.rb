# == Schema Information
#
# Table name: technologies
#
#  id         :uuid             not null, primary key
#  homepage   :string
#  shortcut   :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Technology do
  describe 'factory' do
    context 'with required attributes' do
      subject(:technology) { build(:technology) }

      it 'is valid' do
        expect(technology).to be_valid
      end
    end

    context 'with all attributes' do
      subject(:technology) { build(:technology, :all) }

      it 'is valid' do
        expect(technology).to be_valid
      end
    end
  end

  describe 'association' do
    it { is_expected.to have_many(:articles).through(:technology_assignments) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'scope' do
    describe '.search_by' do
      let(:title_to_find) { create(:technology, title: 'Title 1') }
      let(:title_not_to_find) { create(:technology, title: 'Title 2') }

      it 'returns records with the specified title' do
        expect(described_class.search_by('Title 1')).to include(title_to_find)
      end

      it 'does not return records with a different title' do
        expect(described_class.search_by('Title 1')).not_to include(title_not_to_find)
      end
    end

    describe '.for_article' do
      let(:article) { create(:article) }
      let(:technology) { create(:technology) }
      let(:technology_assignment) { create(:technology_assignment, article:, technology:) }
      let(:different_technology) { create(:technology) }

      it 'returns technologies for the specified article' do
        technology_assignment

        expect(described_class.for_article(article)).to include(technology)
      end

      it 'does not return different technologies' do
        expect(described_class.for_article(article)).not_to include(different_technology)
      end
    end
  end
end
