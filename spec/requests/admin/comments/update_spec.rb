require 'rails_helper'

RSpec.describe '/admin/comments' do
  let(:admin) { create(:user) }
  let(:comment) { create(:comment) }

  let(:valid_attributes) { attributes_for(:comment, title: 'Updated Comment title') }
  let(:invalid_attributes) { attributes_for(:comment, title: nil) }

  describe 'PATCH /update' do
    context 'when authorized with valid parameters' do
      before do
        sign_in admin

        patch admin_comment_url(id: comment.id), params: { comment: valid_attributes }
      end

      it 'updates the requested comment' do
        expect(comment.updated_at < comment.reload.updated_at).to be true
      end

      it 'redirects to the comment' do
        expect(response).to redirect_to(admin_comment_url(id: comment.id))
      end

      it 'renders a response with 302 :found status' do
        expect(response).to have_http_status(:found)
      end
    end

    context 'when authorized with invalid parameters' do
      before do
        sign_in admin

        patch admin_comment_url(id: comment.id), params: { comment: invalid_attributes }
      end

      it 'does not update the requested comment' do
        expect(comment.updated_at < comment.reload.updated_at).to be false
      end

      it 'renders the edit template' do
        expect(response.body).to include 'Edit'
      end

      it 'renders a response with 422 :unprocessable_entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when public with valid parameters' do
      it 'does not update the requested comment' do
        expect(comment.updated_at < comment.reload.updated_at).to be false
      end

      it 'redirects to login' do
        patch admin_comment_url(id: comment.id), params: { comment: valid_attributes }

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        patch admin_comment_url(id: comment.id), params: { comment: valid_attributes }

        expect(response).to have_http_status(:found)
      end
    end

    context 'when public with invalid parameters' do
      it 'does not update the requested comment' do
        expect(comment.updated_at < comment.reload.updated_at).to be false
      end

      it 'redirects to login' do
        patch admin_comment_url(id: comment.id), params: { comment: invalid_attributes }

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        patch admin_comment_url(id: comment.id), params: { comment: invalid_attributes }

        expect(response).to have_http_status(:found)
      end
    end
  end
end
