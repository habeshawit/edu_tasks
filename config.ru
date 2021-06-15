require './config/environment'

# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end
# require "yaml"
# require 'sass/plugin/rack'
# use Sass::Plugin::Rack
use Rack::MethodOverride
run ApplicationController
use CoursesController
use UsersController

