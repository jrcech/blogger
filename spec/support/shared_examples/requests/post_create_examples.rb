# frozen_string_literal: true

RSpec.shared_examples 'creates a new record' do |url, resource, attributes|
  it 'creates a new record' do
    params = {}
    params[resource] = send(attributes)

    expect do
      post send(url, params: params)
    end.to change(resource.to_s.classify.safe_constantize.all, :count).by(1)
  end
end
