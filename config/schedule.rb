# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
env :GEM_PATH, ENV['GEM_PATH']
set :environment, :production
require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, 'log/cron.log'
set :bundle_command, "/root/.rbenv/shims/bundle"

# Could not find command "script/runner"のエラー対処のため
job_type :custom_runner,
  "cd :path && /root/.rbenv/shims/bundle exec rails runner -e :environment ':task' :output"
# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 1.day, at: '11:59am' do # 昼の12時に配信
  custom_runner "ProductPrice.crawling_price"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
