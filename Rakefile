ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "drop databases"
task :drop do
    puts "Dropping databases"
    system "rm db/development.sqlite && rm db/test.sqlite && rm db/schema.rb"
end

desc "Migrates both databases"
task :migrations do
    puts "Migratinf databases"
    system "rake db:migrate && rake db:migrate SINNATRA_ENV=test"
end

desc "Resets database"
task :reset_db do
    Rake::Task["drop"]
    Rake::Task['migrations']
    system "shotgun"
end