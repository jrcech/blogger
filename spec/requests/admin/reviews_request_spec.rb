# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  include_examples 'GET /index authenticated', :admin_reviews_url
  include_examples 'GET /show authenticated', :admin_review_url, :review
  include_examples 'GET /new authenticated', :new_admin_review_url
  include_examples 'GET /edit authenticated', :edit_admin_review_url, :review

  include_examples 'POST authenticated', :admin_reviews_url, :review
  include_examples 'PATCH authenticated', :admin_review_url, :review
  include_examples 'DELETE authenticated', :admin_review_url, :review
end
