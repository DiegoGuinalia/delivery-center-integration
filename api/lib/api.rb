# frozen_string_literal: true

require 'erb'
require 'forwardable'
require 'json'
require 'roda'
require 'bunny'
require 'redis'
require 'mongoid'
require 'dry-validation'
require 'interactor'
require 'awrence'
require 'faraday'

# database
Mongoid.load!(File.join(Dir.pwd, 'config', 'mongoid.yml'))

# Load support files
Dir["#{Dir.pwd}/lib/support/**/*.rb"].sort.each { |file| require file }

# Load Web Stories routes
require './app'

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

# Load api services
Dir["#{Dir.pwd}/lib/services/**/*.rb"].sort.each { |file| require file }

APP_NAME = ENV.fetch('APP_NAME', 'delivery-center-integration')
RUBY_ENV = ENV.fetch('RUBY_ENV', 'development').downcase
VERSION = File.read('version.txt').chomp
