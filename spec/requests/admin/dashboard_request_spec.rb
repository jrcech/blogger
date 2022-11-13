# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  include_examples 'Admin GET /index', :admin_root_url
end
