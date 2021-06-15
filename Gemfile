source 'http://rubygems.org'

gem 'ruby'
gem 'sinatra'
gem 'activerecord', '~> 4.2', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
# gem 'sqlite3', '~> 1.3.13'
gem 'thin'
gem 'shotgun'
gem 'pry'
gem 'bcrypt'  #encrypts password
# gem 'tux'
gem 'rb-readline'
gem 'rack-flash3'
gem  'sinatra-flash'
# gem 'sass'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :development do
 gem 'sqlite3', '~> 1.3.13'
 gem "tux"
end

group :production do
 gem 'pg', '~> 0.11'
end
