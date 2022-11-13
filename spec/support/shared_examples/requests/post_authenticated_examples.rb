# frozen_string_literal: true

RSpec.shared_examples 'POST authenticated' do |url, resource|
  describe 'POST' do
    let(:valid_attributes) {
      associations_attributes = create(resource).attributes.select {
        |key| key.to_s.match(/_id/)
      }

      resource_attributes = attributes_for(resource)

      resource_attributes.merge(associations_attributes)
    }

    let(:invalid_attributes) { attributes_for resource, :invalid }

    context 'with an authenticated user' do
      before do
        sign_in_user
      end

      context 'with valid attributes' do
        include_examples 'creates a new record', url, resource, :valid_attributes
      end

      context 'with invalid attributes' do
        include_examples 'does not create a new record', url, resource, :invalid_attributes
      end
    end

    context 'with a guest' do
      context 'with valid attributes' do
        include_examples 'does not create a new record', url, resource, :valid_attributes
      end

      context 'with invalid attributes' do
        include_examples 'does not create a new record', url, resource, :invalid_attributes
      end
    end
  end
end
