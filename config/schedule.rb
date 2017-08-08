# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, 'log/cron.log'
# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 1.day, at: '10:27pm' do # 昼の12時に配信
  runner "ProductPrice.crawling_price"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
