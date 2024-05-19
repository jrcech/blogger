require 'rails_helper'

RSpec.describe '/admin/technologies' do
  let(:admin) { create(:user) }
  let(:article) { create(:article) }

  let(:valid_attributes) { attributes_for(:technology, article_id: article.id) }
  let(:invalid_attributes) { attributes_for(:technology, title: nil) }

  describe 'POST /create' do
    context 'when authorized with valid parameters' do
      before do
        sign_in admin
      end

      it 'creates a new Technology' do
        expect do
          post admin_technologies_url, params: { technology: valid_attributes }
        end.to change(Technology, :count).by(1)
      end

      it 'redirects to the created technology' do
        post admin_technologies_url, params: { technology: valid_attributes }

        expect(response).to redirect_to(admin_technology_url(id: Technology.last.id))
      end

      it 'renders a response with 302 :see_other status' do
        post admin_technologies_url, params: { technology: valid_attributes }

        expect(response).to have_http_status(:found)
      end
    end

    context 'when authorized with invalid parameters' do
      before do
        sign_in admin
      end

      it 'does not create a new Technology' do
        expect do
          post admin_technologies_url, params: { technology: invalid_attributes }
        end.not_to change(Technology, :count)
      end

      it 'renders the new template' do
        post admin_technologies_url, params: { technology: invalid_attributes }

        expect(response.body).to include 'New Technology'
      end

      it 'renders a response with 422 :unprocessable_entity status' do
        post admin_technologies_url, params: { technology: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when public with valid parameters' do
      it 'does not create a new Technology' do
        expect do
          post admin_technologies_url, params: { technology: valid_attributes }
        end.not_to change(Technology, :count)
      end

      it 'redirects to login' do
        post admin_technologies_url, params: { technology: valid_attributes }

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        post admin_technologies_url, params: { technology: valid_attributes }

        expect(response).to have_http_status(:found)
      end
    end

    context 'when public with invalid parameters' do
      it 'does not create a new Technology' do
        expect do
          post admin_technologies_url, params: { technology: invalid_attributes }
        end.not_to change(Technology, :count)
      end

      it 'redirects to login' do
        post admin_technologies_url, params: { technology: invalid_attributes }

        expect(response).to redirect_to(new_session_url)
      end

      it 'renders a response with 302 :found status' do
        post admin_technologies_url, params: { technology: invalid_attributes }

        expect(response).to have_http_status(:found)
      end
    end
  end
end
