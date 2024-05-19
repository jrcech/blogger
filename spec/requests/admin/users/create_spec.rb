require 'rails_helper'

RSpec.describe '/admin/users' do
  let(:admin) { create(:user) }

  let(:valid_attributes) { attributes_for(:user) }
  let(:invalid_attributes) { attributes_for(:user, email: nil) }

  describe 'POST /create' do
    context 'when authorized with valid parameters' do
      before do
        sign_in admin
      end

      it 'creates a new User' do
        expect do
          post admin_users_url, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post admin_users_url, params: { user: valid_attributes }

        expect(response).to redirect_to(admin_user_url(id: User.last.id))
      end

      it 'renders a response with 302 :see_other status' do
        post admin_users_url, params: { user: valid_attributes }

        expect(response).to have_http_status(:found)
      end
    end

    context 'when authorized with invalid parameters' do
      before do
        sign_in admin
      end

      it 'does not create a new User' do
        expect do
          post admin_users_url, params: { user: invalid_attributes }
        end.not_to change(User, :count)
      end

      it 'renders the new template' do
        post admin_users_url, params: { user: invalid_attributes }

        expect(response.body).to include 'New User'
      end

      it 'renders a response with 422 :unprocessable_entity status' do
        post admin_users_url, params: { user: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when public with valid parameters' do
      it 'does not create a new User' do
        expect do
          post admin_users_url, params: { user: valid_attributes }
        end.not_to change(User, :count)
      end

      it 'redirects to login' do
        post admin_users_url, params: { user: valid_attributes }

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        post admin_users_url, params: { user: valid_attributes }

        expect(response).to have_http_status(:found)
      end
    end

    context 'when public with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post admin_users_url, params: { user: invalid_attributes }
        end.not_to change(User, :count)
      end

      it 'redirects to login' do
        post admin_users_url, params: { user: invalid_attributes }

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        post admin_users_url, params: { user: invalid_attributes }

        expect(response).to have_http_status(:found)
      end
    end
  end
end
