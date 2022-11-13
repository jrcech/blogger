# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  include_examples 'Admin GET /index', :admin_articles_url
  include_examples 'Admin GET /show', :admin_article_url, :article
  include_examples 'Admin GET /new', :new_admin_article_url
  include_examples 'Admin GET /edit', :edit_admin_article_url, :article

  include_examples 'Admin POST', :admin_articles_url, :article
  include_examples 'Admin PATCH', :admin_article_url, :article
  include_examples 'Admin DELETE', :admin_article_url, :article
end
