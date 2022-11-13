# frozen_string_literal: true

RSpec.shared_examples 'does not create a new record' do |url, resource, attributes|
  it 'does not create a new record' do
    params = {}
    params[resource] = send(attributes)

    expect do
      post send(url, params: params)
    end.not_to change(resource.to_s.classify.safe_constantize.all, :count)
  end
end
