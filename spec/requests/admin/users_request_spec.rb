# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include_examples 'GET /index authenticated', :admin_users_url
  include_examples 'GET /show authenticated', :admin_user_url, :user
  include_examples 'GET /new authenticated', :new_admin_user_url
  include_examples 'GET /edit authenticated', :edit_admin_user_url, :user

  include_examples 'POST authenticated', :admin_users_url, :user
  include_examples 'PATCH authenticated', :admin_user_url, :user
  include_examples 'DELETE authenticated', :admin_user_url, :user
end
