Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  config.populate_empty_backtraces = true
  config.use_sidekiq 'queue' => 'default'

  config.enabled = false unless Rails.env.production?
  config.environment = Rails.env
end
