# frozen_string_literal: true

RSpec.shared_examples 'Admin POST' do |url, resource|
  describe 'POST' do
    let(:factory) { create(resource) }

    let(:factory_associations_attributes) do
      factory.attributes.select do |key|
        key.to_s.match(/_id/)
      end
    end

    let(:valid_attributes) do
      attributes_for(resource).merge(factory_associations_attributes)
    end

    let(:invalid_attributes) { attributes_for(resource, :invalid) }

    context 'with an authenticated user' do
      before do
        sign_in_user
      end

      context 'with valid attributes' do
        it 'creates a new record' do
          params = {}
          params[resource] = valid_attributes

          expect do
            post send(url, params:)
          end.to change(resource.to_s.classify.safe_constantize.all, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new record' do
          params = {}
          params[resource] = invalid_attributes

          expect do
            post send(url, params:)
          end.not_to change(resource.to_s.classify.safe_constantize.all, :count)
        end
      end
    end

    context 'with a guest' do
      context 'with valid attributes' do
        it 'does not create a new record' do
          params = {}
          params[resource] = valid_attributes

          expect do
            post send(url, params:)
          end.not_to change(resource.to_s.classify.safe_constantize.all, :count)
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new record' do
          params = {}
          params[resource] = invalid_attributes

          expect do
            post send(url, params:)
          end.not_to change(resource.to_s.classify.safe_constantize.all, :count)
        end
      end
    end
  end
end
