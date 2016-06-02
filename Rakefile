require './app/hotel_api.rb'
require 'sinatra/activerecord/rake'

desc "Config test database"
task :test_database_setup do
  Rake::Task['db:migrate']
  Rake::Task['db:test:prepare']
end

desc "Config development/production database"
task :database_setup do
  Rake::Task['db:migrate']
  Rake::Task['db:seed']
end