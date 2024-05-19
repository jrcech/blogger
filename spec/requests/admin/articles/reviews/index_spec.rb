require 'rails_helper'

RSpec.describe '/admin/articles/:article_id/reviews' do
  let(:admin) { create(:user) }
  let(:article) { create(:article) }
  let(:reviews) { create_list(:review, 3, article:) }

  describe 'GET /index' do
    context 'when authorized without records' do
      before do
        sign_in admin

        get admin_article_reviews_url(article_id: article.id)
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

        reviews

        get admin_article_reviews_url(article_id: article.id)
      end

      it 'loads all records' do
        aggregate_failures do
          reviews.each do |review|
            expect(response.body).to include(review.title)
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
        get admin_article_reviews_url(article_id: article.id)
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
