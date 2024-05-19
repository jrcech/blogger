# == Schema Information
#
# Table name: articles
#
#  id         :uuid             not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Article do
  describe 'factory' do
    context 'with required attributes' do
      subject(:article) { build(:article) }

      it 'is valid' do
        expect(article).to be_valid
      end
    end
  end

  describe 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:technology_assignments) }
    it { is_expected.to have_many(:technologies).through(:technology_assignments) }
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_many(:comments) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :content }
  end

  describe 'scope' do
    describe '.search_by' do
      let(:title_to_find) { create(:article, title: 'Title 1') }
      let(:title_not_to_find) { create(:article, title: 'Title 2') }

      it 'returns records with the specified title' do
        expect(described_class.search_by('Title 1')).to include(title_to_find)
      end

      it 'does not return records with a different title' do
        expect(described_class.search_by('Title 1')).not_to include(title_not_to_find)
      end
    end
  end
end
