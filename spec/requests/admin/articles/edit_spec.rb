require 'rails_helper'

RSpec.describe '/admin/articles' do
  let(:admin) { create(:user) }
  let(:article) { create(:article) }

  describe 'GET /edit' do
    context 'when authorized' do
      before do
        sign_in admin

        get edit_admin_article_url(id: article.id)
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
        get edit_admin_article_url(id: article.id)
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
