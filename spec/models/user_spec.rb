# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  auth_token      :string
#  email           :string           not null
#  first_name      :string
#  last_name       :string
#  password_digest :string           not null
#  user_name       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe User do
  describe 'factory' do
    context 'with required attributes' do
      subject(:user) { build(:user) }

      it 'is valid' do
        expect(user).to be_valid
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
    it { is_expected.to have_many(:articles) }
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_many(:comments) }
  end

  describe 'validation' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to have_secure_password }
  end

  describe 'normalization' do
    it do
      is_expected.to normalize(:email).from("  TEST@EXAMPLE.COM\n ").to('test@example.com')
    end
  end

  describe 'token generation' do
    let(:user) { create(:user) }
    let(:token) { user.generate_token_for(:password_reset) }

    it 'creates a token for password reset' do
      expect(token).not_to be_nil
    end

    it 'finds the user by token immediately after generation' do
      expect(described_class.find_by_token_for(:password_reset, token)).to eq(user)
    end

    it 'does not find the user by token after it has expired' do
      Timecop.freeze do
        token

        Timecop.travel(16.minutes.from_now)

        expect(described_class.find_by_token_for(:password_reset, token)).to be_nil
      end
    end
  end
end
