# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  include_examples 'Admin GET /index', :admin_reviews_url
  include_examples 'Admin GET /show', :admin_review_url, :review
  include_examples 'Admin GET /new', :new_admin_review_url
  include_examples 'Admin GET /edit', :edit_admin_review_url, :review

  include_examples 'Admin POST', :admin_reviews_url, :review
  include_examples 'Admin PATCH', :admin_review_url, :review
  include_examples 'Admin DELETE', :admin_review_url, :review
end
