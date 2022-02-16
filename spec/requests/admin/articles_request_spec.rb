# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  before do
    resource_for :articles, :admin
  end

  actions = %i[
    index
    show
    new
    edit
  ]

  actions.each do |action|
    include_examples "GET /#{action} authenticated"
  end

  include_examples 'POST authenticated'
  include_examples 'PATCH authenticated'
  include_examples 'DELETE authenticated'
end
