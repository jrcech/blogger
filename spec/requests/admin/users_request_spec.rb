# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  include_examples 'Admin GET /index', :admin_users_url
  include_examples 'Admin GET /show', :admin_user_url, :user
  include_examples 'Admin GET /new', :new_admin_user_url
  include_examples 'Admin GET /edit', :edit_admin_user_url, :user

  include_examples 'Admin POST', :admin_users_url, :user
  include_examples 'Admin PATCH', :admin_user_url, :user
  include_examples 'Admin DELETE', :admin_user_url, :user
end
