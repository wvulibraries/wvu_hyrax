# Sidekiq.configure_server do |config|
#   config.redis = { url: <%= ENV.fetch("REDIS_URL_SIDEKIQ") { "redis://hyrax_redis:6379/1" } %> }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: <%= ENV.fetch("REDIS_URL_SIDEKIQ") { "redis://hyrax_redis:6379/1" } %> }
# end

# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://hyrax_redis:6379/12' }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://hyrax_redis:6379/12' }
# end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://hyrax_redis:6379/12' }
  schedule_file = "config/schedule.yml"
  if File.exists?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://hyrax_redis:6379/12' }
end