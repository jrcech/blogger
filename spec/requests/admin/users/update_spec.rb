require 'rails_helper'

RSpec.describe '/admin/users' do
  let(:admin) { create(:user) }
  let(:user) { create(:user) }

  let(:valid_attributes) { attributes_for(:user, email: 'updated@example.com') }
  let(:invalid_attributes) { attributes_for(:user, email: nil) }

  describe 'PATCH /update' do
    context 'when authorized with valid parameters' do
      before do
        sign_in admin

        patch admin_user_url(id: user.id), params: { user: valid_attributes }
      end

      it 'updates the requested user' do
        expect(user.updated_at < user.reload.updated_at).to be true
      end

      it 'redirects to the user' do
        expect(response).to redirect_to(admin_user_url(id: user.id))
      end

      it 'renders a response with 302 :found status' do
        expect(response).to have_http_status(:found)
      end
    end

    context 'when authorized with invalid parameters' do
      before do
        sign_in admin

        patch admin_user_url(id: user.id), params: { user: invalid_attributes }
      end

      it 'does not update the requested user' do
        expect(user.updated_at < user.reload.updated_at).to be false
      end

      it 'renders the edit template' do
        expect(response.body).to include 'Edit'
      end

      it 'renders a response with 422 :unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when public with valid parameters' do
      it 'does not update the requested user' do
        expect(user.updated_at < user.reload.updated_at).to be false
      end

      it 'redirects to login' do
        patch admin_user_url(id: user.id), params: { user: valid_attributes }

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        patch admin_user_url(id: user.id), params: { user: valid_attributes }

        expect(response).to have_http_status(:found)
      end
    end

    context 'when public with invalid parameters' do
      it 'does not update the requested user' do
        expect(user.updated_at < user.reload.updated_at).to be false
      end

      it 'redirects to login' do
        patch admin_user_url(id: user.id), params: { user: invalid_attributes }

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        patch admin_user_url(id: user.id), params: { user: invalid_attributes }

        expect(response).to have_http_status(:found)
      end
    end
  end
end
