require 'rails_helper'

RSpec.describe '/admin/reviews' do
  let(:admin) { create(:user) }
  let(:review) { create(:review) }

  describe 'DELETE /destroy' do
    context 'when authorized' do
      before do
        sign_in admin

        review
      end

      it 'destroys the requested review' do
        expect do
          delete admin_review_url(id: review.id)
        end.to change(Review, :count).by(-1)
      end

      it 'redirects to the reviews list' do
        delete admin_review_url(id: review.id)

        expect(response).to redirect_to(admin_reviews_url)
      end

      it 'renders a response with 303 :see_other status' do
        delete admin_review_url(id: review.id)

        expect(response).to have_http_status(:see_other)
      end
    end

    context 'when public' do
      before do
        review
      end

      it 'does not destroy the requested review' do
        expect do
          delete admin_review_url(id: review.id)
        end.not_to change(Review, :count)
      end

      it 'redirects to login' do
        delete admin_review_url(id: review.id)

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        delete admin_review_url(id: review.id)

        expect(response).to have_http_status(:found)
      end
    end
  end
end
