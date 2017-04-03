Rollbar.configure do |config|
  config.populate_empty_backtraces = true
  config.use_sidekiq 'queue' => 'default'

  config.enabled = false unless Rails.env.production?
end
