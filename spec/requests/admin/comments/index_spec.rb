require 'rails_helper'

RSpec.describe '/admin/comments' do
  let(:admin) { create(:user) }
  let(:article) { create(:article) }
  let(:comments) { create_list(:comment, 3, article:) }

  describe 'GET /index' do
    context 'when authorized without records' do
      before do
        sign_in admin

        get admin_comments_url
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

        comments

        get admin_comments_url
      end

      it 'loads all records' do
        aggregate_failures do
          comments.each do |comment|
            expect(response.body).to include(comment.title)
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
        get admin_comments_url
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
