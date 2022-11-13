# frozen_string_literal: true

RSpec.shared_examples 'updates the record' do |url, resource, attributes|
  it 'updates the new record' do
    params = {}
    params[resource] = send(attributes)

    patch send(url, id: factory.id), params: params

    expect(factory.updated_at < factory.reload.updated_at).to eq true
  end
end
