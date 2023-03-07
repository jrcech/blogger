Sentry.init do |config|
  config.dsn = Rails.application.credentials.dig(:sentry, :dsn)
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  config.enabled_environments = %w[production staging development]

  config.traces_sample_rate = 1.0
end
