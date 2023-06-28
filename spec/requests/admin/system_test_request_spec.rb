# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SystemTest' do
  include_examples 'Admin GET /index', :admin_system_test_url
end
