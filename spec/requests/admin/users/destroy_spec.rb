require 'rails_helper'

RSpec.describe '/admin/users' do
  let(:admin) { create(:user) }
  let(:user) { create(:user) }

  describe 'DELETE /destroy' do
    context 'when authorized' do
      before do
        sign_in admin

        user
      end

      it 'destroys the requested user' do
        expect do
          delete admin_user_url(id: user.id)
        end.to change(User, :count).by(-1)
      end

      it 'does not destroy current user' do
        expect do
          delete admin_user_url(id: admin.id)
        end.not_to change(User, :count)
      end

      it 'redirects to the users list' do
        delete admin_user_url(id: user.id)

        expect(response).to redirect_to(admin_users_url)
      end

      it 'renders a response with 303 :see_other status' do
        delete admin_user_url(id: user.id)

        expect(response).to have_http_status(:see_other)
      end
    end

    context 'when public' do
      before do
        user
      end

      it 'does not destroy the requested user' do
        expect do
          delete admin_user_url(id: user.id)
        end.not_to change(User, :count)
      end

      it 'redirects to login' do
        delete admin_user_url(id: user.id)

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        delete admin_user_url(id: user.id)

        expect(response).to have_http_status(:found)
      end
    end
  end
end
