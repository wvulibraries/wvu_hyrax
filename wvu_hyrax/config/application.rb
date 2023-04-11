require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WvuHyrax
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # use SideKiq by default
    config.active_job.queue_adapter = :sidekiq

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # CAS
    config.rack_cas.server_url = 'https://ssodev.wvu.edu/cas/' unless Rails.env.production?
    config.rack_cas.server_url = 'https://sso.wvu.edu/cas/' if Rails.env.production?
    config.rack_cas.service = "/users/service"
    
    # force ssl
    # config.force_ssl = true if Rails.env.production?
    
    # session store
    config.session_store :cookie_store, expire_after: nil, secure: true if Rails.env.production?
    config.session_store :cookie_store, key: 'cas', expire_after: 12.hours, secure: true if Rails.env.production?    
  end
end
