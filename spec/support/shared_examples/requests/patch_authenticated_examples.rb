# frozen_string_literal: true

RSpec.shared_examples 'PATCH authenticated' do |url, resource|
  describe 'PATCH' do
    let(:factory) { create(resource) }

    let(:valid_attributes) { attributes_for(resource, :updated) }
    let(:invalid_attributes) { attributes_for(resource, :invalid) }

    context 'with an authenticated user' do
      before do
        sign_in_user
      end

      context 'with valid attributes' do
        it 'updates the new record' do
          params = {}
          params[resource] = valid_attributes

          patch send(url, id: factory.id, params:)

          expect(factory.updated_at < factory.reload.updated_at).to be true
        end
      end

      context 'with invalid attributes' do
        it 'does not update the new record' do
          params = {}
          params[resource] = invalid_attributes

          patch send(url, id: factory.id, params:)

          expect(factory.updated_at < factory.reload.updated_at).to be false
        end
      end
    end

    context 'with a guest' do
      context 'with valid attributes' do
        it 'does not update the new record' do
          params = {}
          params[resource] = valid_attributes

          patch send(url, id: factory.id, params:)

          expect(factory.updated_at < factory.reload.updated_at).to be false
        end
      end

      context 'with invalid attributes' do
        it 'does not update the new record' do
          params = {}
          params[resource] = invalid_attributes

          patch send(url, id: factory.id, params:)

          expect(factory.updated_at < factory.reload.updated_at).to be false
        end
      end
    end
  end
end
