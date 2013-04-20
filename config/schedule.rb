# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

every 1.day, :at => '2:00 pm' do
  rake db:makenyprices
end

every 1.day, :at => '2:05 pm' do
  rake db:makesfprices
end

every 1.day, :at => '2:10 am' do
  rake db:makedcprices
end

every 1.day, :at => '2:15 am' do
  rake db:makecorvaraprices
end

# Learn more: http://github.com/javan/whenever
