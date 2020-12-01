#rake gives us the ability to quickly make files and set up automated tasks. 

ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'   #needed to load rake tasks from the sinatra-activerecord gem

desc 'Console'
task :console do
    Pry.start
end