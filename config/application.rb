$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

Dir[File.expand_path('../../api/*.rb', __FILE__)].each do |f|
  require f
end

require 'goliath'
require 'api'
require 'anshabdul_app'

# require 'eventmachine'
require 'fiber'
require 'em-synchrony/em-http'
require 'em-synchrony/mysql2'

require 'json'
require 'securerandom'

require 'erb'

environment = ENV['RACK_ENV']

keystone = YAML.load(ERB.new(File.read(File.expand_path('../keystone.yml', __FILE__))).result)[environment]
Anshabdul::Keystone.config(keystone)

mysql = YAML.load(ERB.new(File.read(File.expand_path('../database.yml', __FILE__))).result)[environment]
Anshabdul::Storage.config(mysql)
