require 'rails_helper'

RSpec.describe '/admin/users' do
  let(:admin) { create(:user) }
  let(:user) { create(:user) }

  describe 'GET /show' do
    context 'when authorized' do
      before do
        sign_in admin

        get admin_user_url(id: user.id)
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'renders a response with 200 :ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when public' do
      before do
        get admin_user_url(id: user.id)
      end

      it 'redirects to login' do
        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        expect(response).to have_http_status(:found)
      end
    end
  end
end
