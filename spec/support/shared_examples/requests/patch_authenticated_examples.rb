# frozen_string_literal: true

RSpec.shared_examples 'PATCH authenticated' do |url, resource|
  describe 'PATCH' do
    let(:factory) { create resource }

    let(:valid_attributes) { attributes_for resource, :updated }
    let(:invalid_attributes) { attributes_for resource, :invalid }

    context 'with an authenticated user' do
      before do
        sign_in_user
      end

      context 'with valid attributes' do
        include_examples 'updates the record', url, resource, :valid_attributes
      end

      context 'with invalid attributes' do
        include_examples 'does not update the record', url, resource, :invalid_attributes
      end
    end

    context 'with a guest' do
      context 'with valid attributes' do
        include_examples 'does not update the record', url, resource, :valid_attributes
      end

      context 'with invalid attributes' do
        include_examples 'does not update the record', url, resource, :invalid_attributes
      end
    end
  end
end
