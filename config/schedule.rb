# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:

# set :output, "/path/to/my/cron_log.log"

# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end

# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# NOTE: cron에서 실행될 때, 환경변수가 미연계 상태가 되기 때문에, 최신화 처리가 필요.
ENV.each { |k, v| env(k, v) }

rails_env = ENV['RAILS_ENV'] ||= 'development'
set :output, error: 'log/crontab_error.log', standard: 'log/crontab.log'
set :environment, rails_env

# NOTE: 터미널에서 whenever --update-crontab으로 최신 반영
every 5.minutes do
  runner "SyncGithubBatch.run"
end
