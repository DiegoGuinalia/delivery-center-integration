# frozen_string_literal: true

require 'erb'
require 'forwardable'
require 'json'
require 'roda'
require 'bunny'
require 'redis'
require 'sidekiq'
require 'mongoid'
require 'dry-validation'
require 'interactor'

# database
Mongoid.load!(File.join(Dir.pwd, 'config', 'mongoid.yml'))

# Load support files
Dir["#{Dir.pwd}/lib/support/**/*.rb"].sort.each { |file| require file }

# Load Web Stories routes
require './app'

# Load Workers

require_relative 'workers/checker'

# Load api Operations
#Dir["#{Dir.pwd}/lib/services/**/*.rb"].sort.each { |file| require file }

# Load api Models
Dir["#{Dir.pwd}/models/**/*.rb"].sort.each { |file| require file }

# Load api Controllers
Dir["#{Dir.pwd}/controllers/**/*.rb"].sort.each { |file| require file }

# Load api contracts
Dir["#{Dir.pwd}/lib/contracts/**/*.rb"].sort.each { |file| require file }

# Load api parsers
Dir["#{Dir.pwd}/lib/parsers/**/*.rb"].sort.each { |file| require file }

# Load api operations
Dir["#{Dir.pwd}/lib/operations/**/*.rb"].sort.each { |file| require file }

APP_NAME = ENV.fetch('APP_NAME', 'delivery-center-integration')
RUBY_ENV = ENV.fetch('RUBY_ENV', 'development').downcase
VERSION = File.read('version.txt').chomp

def set_client_sidekiq
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_HOST'] }
  end
end

set_client_sidekiq if ENV['APP_NAME'] == 'delivery-center-integration'
