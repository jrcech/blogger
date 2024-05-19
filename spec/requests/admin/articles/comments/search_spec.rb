require 'rails_helper'

RSpec.describe '/admin/articles/:article_id/comments' do
  let(:admin) { create(:user) }
  let(:article) { create(:article) }
  let(:comments) { create_list(:comment, 3, article:) }

  describe 'GET /search' do
    context 'when authorized without records' do
      before do
        sign_in admin

        get search_admin_article_comments_url(article_id: article.id), params: { search_query: 'empty search' }
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

        get search_admin_article_comments_url(article_id: article.id), params: { search_query: comments.first.title }
      end

      it 'finds the record' do
        expect(response.body).to include(comments.first.title)
      end

      it 'does not find other record' do
        expect(response.body).not_to include(comments.last.title)
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'renders a response with 200 :ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when authorized with records and wrong search' do
      before do
        sign_in admin

        get search_admin_article_comments_url(article_id: article.id), params: { search_query: 'wrong search' }
      end

      it 'does not find records' do
        aggregate_failures do
          comments.each do |comment|
            expect(response.body).not_to include(comment.title)
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
        get search_admin_article_comments_url(article_id: article.id), params: { search_query: comments.first.title }
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
