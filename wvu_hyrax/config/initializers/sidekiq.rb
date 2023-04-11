sidekiq_config = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/12", password: ENV['REDIS_PASSWORD'], namespace: "sidekiq" }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
  schedule_file = "config/schedule.yml"
  if File.exists?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
  config.logger.level = Logger.const_get(ENV.fetch('LOG_LEVEL', 'info').upcase.to_s)
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end