require 'rails_helper'

RSpec.describe '/admin/comments' do
  let(:admin) { create(:user) }
  let(:comment) { create(:comment) }

  describe 'DELETE /destroy' do
    context 'when authorized' do
      before do
        sign_in admin

        comment
      end

      it 'destroys the requested comment' do
        expect do
          delete admin_comment_url(id: comment.id)
        end.to change(Comment, :count).by(-1)
      end

      it 'redirects to the comments list' do
        delete admin_comment_url(id: comment.id)

        expect(response).to redirect_to(admin_comments_url)
      end

      it 'renders a response with 303 :see_other status' do
        delete admin_comment_url(id: comment.id)

        expect(response).to have_http_status(:see_other)
      end
    end

    context 'when public' do
      before do
        comment
      end

      it 'does not destroy the requested comment' do
        expect do
          delete admin_comment_url(id: comment.id)
        end.not_to change(Comment, :count)
      end

      it 'redirects to login' do
        delete admin_comment_url(id: comment.id)

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        delete admin_comment_url(id: comment.id)

        expect(response).to have_http_status(:found)
      end
    end
  end
end
