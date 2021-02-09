# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require './lib/api'
require 'rack/test'
require 'factory_bot'
require 'mongoid-rspec'
require 'vcr'
require 'database_cleaner-mongoid'

# Load support
Dir["#{Dir.pwd}/spec/support/**/*.rb"].sort.each { |file| require file }

module RequestHelper
  include Rack::Test::Methods

  def app
    App
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request

  config.include Mongoid::Matchers

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
end
