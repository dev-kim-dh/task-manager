# NOTE: https://shohheyhey.com/docker-redis-sidekiq/

redis_config = YAML.load_file('config/redis.yml')[ENV['RAILS_ENV']]
p "@@@@@@@@@@@@@@@@@@@@@"
p ENV['RAILS_ENV']
p "@@@@@@@@@@@@@@@@@@@@@"
redis_config['db'] = redis_config['db']['sidekiq']

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{redis_config['host']}/#{redis_config['db']}"
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{redis_config['host']}/#{redis_config['db']}"
  }
end
