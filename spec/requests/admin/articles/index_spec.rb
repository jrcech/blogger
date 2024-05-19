require 'rails_helper'

RSpec.describe '/admin/articles' do
  let(:admin) { create(:user) }
  let(:articles) { create_list(:article, 3) }

  describe 'GET /index' do
    context 'when authorized without records' do
      before do
        sign_in admin

        get admin_articles_url
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

        articles

        get admin_articles_url
      end

      it 'loads all records' do
        aggregate_failures do
          articles.each do |article|
            expect(response.body).to include(article.title)
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
        get admin_articles_url
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
