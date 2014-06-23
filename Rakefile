require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

task :environment do
  ENV["RACK_ENV"] ||= 'development'
  require File.expand_path("../config/environment", __FILE__)
end

task :routes => :environment do
  Anshabdul::API.routes.each do |route|
    p route
  end
end

