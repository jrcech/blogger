# == Schema Information
#
# Table name: comments
#
#  id         :uuid             not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment do
  describe 'factory' do
    context 'with required attributes' do
      subject(:comment) { build(:comment) }

      it 'is valid' do
        expect(comment).to be_valid
      end
    end
  end

  describe 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:article) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :content }
  end

  describe 'scope' do
    describe '.search_by' do
      let(:title_to_find) { create(:comment, title: 'Title 1') }
      let(:title_not_to_find) { create(:comment, title: 'Title 2') }

      it 'returns records with the specified title' do
        expect(described_class.search_by('Title 1')).to include(title_to_find)
      end

      it 'does not return records with a different title' do
        expect(described_class.search_by('Title 1')).not_to include(title_not_to_find)
      end
    end

    describe '.for_article' do
      let(:article) { create(:article) }
      let(:comment) { create(:comment, article:) }
      let(:different_comment) { create(:comment) }

      it 'returns comments for the specified article' do
        expect(described_class.for_article(article)).to include(comment)
      end

      it 'does not return different comments' do
        expect(described_class.for_article(article)).not_to include(different_comment)
      end
    end
  end
end
