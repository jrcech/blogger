# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments' do
  include_examples 'Admin GET /index', :admin_comments_url
  include_examples 'Admin GET /show', :admin_comment_url, :comment
  include_examples 'Admin GET /new', :new_admin_comment_url
  include_examples 'Admin GET /edit', :edit_admin_comment_url, :comment

  include_examples 'Admin POST', :admin_comments_url, :comment
  include_examples 'Admin PATCH', :admin_comment_url, :comment
  include_examples 'Admin DELETE', :admin_comment_url, :comment
end
