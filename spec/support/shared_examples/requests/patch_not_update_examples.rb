# frozen_string_literal: true

RSpec.shared_examples 'does not update the record' do |url, resource, attributes|
  it 'does not update the new record' do
    params = {}
    params[resource] = send(attributes)

    patch send(url, id: factory.id), params: params

    expect(factory.updated_at < factory.reload.updated_at).to eq false
  end
end
