require 'rails_helper'

RSpec.describe '/admin/technologies' do
  let(:admin) { create(:user) }
  let(:technology) { create(:technology) }

  describe 'DELETE /destroy' do
    context 'when authorized' do
      before do
        sign_in admin

        technology
      end

      it 'destroys the requested technology' do
        expect do
          delete admin_technology_url(id: technology.id)
        end.to change(Technology, :count).by(-1)
      end

      it 'redirects to the technologies list' do
        delete admin_technology_url(id: technology.id)

        expect(response).to redirect_to(admin_technologies_url)
      end

      it 'renders a response with 303 :see_other status' do
        delete admin_technology_url(id: technology.id)

        expect(response).to have_http_status(:see_other)
      end
    end

    context 'when public' do
      before do
        technology
      end

      it 'does not destroy the requested technology' do
        expect do
          delete admin_technology_url(id: technology.id)
        end.not_to change(Technology, :count)
      end

      it 'redirects to login' do
        delete admin_technology_url(id: technology.id)

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        delete admin_technology_url(id: technology.id)

        expect(response).to have_http_status(:found)
      end
    end
  end
end
