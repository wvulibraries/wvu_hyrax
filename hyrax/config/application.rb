require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hyrax
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # use SideKiq by default
    config.active_job.queue_adapter = :sidekiq

    # CAS
    # get cas server url from environment variable
    config.rack_cas.server_url = ENV['CAS_SERVER_URL']
    config.rack_cas.service = "/users/service"    

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Eastern Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    #config.action_controller.perform_caching = true
    #config.cache_store = :redis_store, ENV['REDIS_URL_SIDEKIQ']
  end
end
