require 'rails_helper'

RSpec.describe '/admin/reviews' do
  let(:admin) { create(:user) }
  let(:review) { create(:review) }

  let(:valid_attributes) { attributes_for(:review, title: 'Updated Review title') }
  let(:invalid_attributes) { attributes_for(:review, title: nil) }

  describe 'PATCH /update' do
    context 'when authorized with valid parameters' do
      before do
        sign_in admin

        patch admin_review_url(id: review.id), params: { review: valid_attributes }
      end

      it 'updates the requested review' do
        expect(review.updated_at < review.reload.updated_at).to be true
      end

      it 'redirects to the review' do
        expect(response).to redirect_to(admin_review_url(id: review.id))
      end

      it 'renders a response with 302 :found status' do
        expect(response).to have_http_status(:found)
      end
    end

    context 'when authorized with invalid parameters' do
      before do
        sign_in admin

        patch admin_review_url(id: review.id), params: { review: invalid_attributes }
      end

      it 'does not update the requested review' do
        expect(review.updated_at < review.reload.updated_at).to be false
      end

      it 'renders the edit template' do
        expect(response.body).to include 'Edit'
      end

      it 'renders a response with 422 :unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when public with valid parameters' do
      it 'does not update the requested review' do
        expect(review.updated_at < review.reload.updated_at).to be false
      end

      it 'redirects to login' do
        patch admin_review_url(id: review.id), params: { review: valid_attributes }

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        patch admin_review_url(id: review.id), params: { review: valid_attributes }

        expect(response).to have_http_status(:found)
      end
    end

    context 'when public with invalid parameters' do
      it 'does not update the requested review' do
        expect(review.updated_at < review.reload.updated_at).to be false
      end

      it 'redirects to login' do
        patch admin_review_url(id: review.id), params: { review: invalid_attributes }

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        patch admin_review_url(id: review.id), params: { review: invalid_attributes }

        expect(response).to have_http_status(:found)
      end
    end
  end
end
