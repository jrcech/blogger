# frozen_string_literal: true

RSpec.shared_examples 'POST authenticated' do |url, resource|
  describe 'POST' do
    let(:valid_attributes) do
      associations_attributes = create(resource).attributes.select do |key|
        key.to_s.match(/_id/)
      end

      resource_attributes = attributes_for(resource)

      resource_attributes.merge(associations_attributes)
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
