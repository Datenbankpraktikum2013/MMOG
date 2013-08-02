require 'resque/tasks'
require 'resque_scheduler/tasks'
require 'resque_scheduler/server'

task "resque:setup" => :environment do
    ENV['QUEUE'] = "*"
end