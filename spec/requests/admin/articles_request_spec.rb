# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  include_examples 'GET /index authenticated', :admin_articles_url
  include_examples 'GET /show authenticated', :admin_article_url, :article
  include_examples 'GET /new authenticated', :new_admin_article_url
  include_examples 'GET /edit authenticated', :edit_admin_article_url, :article

  include_examples 'POST authenticated', :admin_articles_url, :article
  include_examples 'PATCH authenticated', :admin_article_url, :article
  include_examples 'DELETE authenticated', :admin_article_url, :article
end
