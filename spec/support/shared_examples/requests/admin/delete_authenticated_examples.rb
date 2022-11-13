# frozen_string_literal: true

RSpec.shared_examples 'Admin DELETE' do |url, resource|
  describe 'DELETE' do
    let(:factory) { create(resource) }

    before do
      factory
    end

    context 'with an authenticated user' do
      before do
        sign_in_user
      end

      it 'destroys the record' do
        expect do
          delete send(url, id: factory.id)
        end.to change(resource.to_s.classify.safe_constantize.all, :count).by(-1)
      end
    end

    context 'with a guest' do
      it 'does not destroy the record' do
        expect do
          delete send(url, id: factory.id)
        end.not_to change(resource.to_s.classify.safe_constantize.all, :count)
      end
    end
  end
end
