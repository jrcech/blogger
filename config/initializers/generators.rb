Rails.application.config.generators do |generators|
  generators.orm :active_record, primary_key_type: :uuid
end
