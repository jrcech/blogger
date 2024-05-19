require 'rails_helper'

RSpec.describe '/admin/users' do
  let(:admin) { create(:user) }
  let(:users) { create_list(:user, 3) }

  describe 'GET /index' do
    context 'when authorized without records' do
      before do
        sign_in admin

        get admin_users_url
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'renders a response with 200 :ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when authorized with records' do
      before do
        sign_in admin

        users

        get admin_users_url
      end

      it 'loads all records' do
        aggregate_failures do
          users.each do |user|
            expect(response.body).to include(user.title)
          end
        end
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
        get admin_users_url
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
