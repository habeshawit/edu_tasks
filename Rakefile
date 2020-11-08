ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'   #needed to load rake tasks

desc 'Console'
task :console do
    Pry.start
end