# frozen_string_literal: true
require_relative 'boot'
require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
Bundler.require(*Rails.groups)
module WorkshopSurvey
  class Application < Rails::Application
    config.assets.quiet = true
    config.generators do |generate|
      generate.helper false
      generate.javascripts false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.test_framework :rspec
      generate.view_specs false
    end
    config.active_record.primary_key = :uuid
    config.action_controller.action_on_unpermitted_parameters = :raise
    config.active_job.queue_adapter = :sidekiq

    config.autoload_paths += Dir[Rails.root.join('app', 'models', 'surveys')]
  end
end
