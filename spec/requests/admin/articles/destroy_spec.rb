require 'rails_helper'

RSpec.describe '/admin/articles' do
  let(:admin) { create(:user) }
  let(:article) { create(:article) }

  describe 'DELETE /destroy' do
    context 'when authorized' do
      before do
        sign_in admin

        article
      end

      it 'destroys the requested article' do
        expect do
          delete admin_article_url(id: article.id)
        end.to change(Article, :count).by(-1)
      end

      it 'redirects to the articles list' do
        delete admin_article_url(id: article.id)

        expect(response).to redirect_to(admin_articles_url)
      end

      it 'renders a response with 303 :see_other status' do
        delete admin_article_url(id: article.id)

        expect(response).to have_http_status(:see_other)
      end
    end

    context 'when public' do
      before do
        article
      end

      it 'does not destroy the requested article' do
        expect do
          delete admin_article_url(id: article.id)
        end.not_to change(Article, :count)
      end

      it 'redirects to login' do
        delete admin_article_url(id: article.id)

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        delete admin_article_url(id: article.id)

        expect(response).to have_http_status(:found)
      end
    end
  end
end
