set :output, "#{path}/log/cron.log"

every 2.hours do
  rake 'fn:news'
end

every 1.day, at: '1:00 am' do
  rake 'fn:limit'
end

every 2.minutes do
  rake 'fn:test'
end