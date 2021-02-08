ENV['RACK_ENV'] = 'test'

require './lib/api'
require 'rack/test'
require 'factory_bot'
require 'mongoid-rspec'

# Load support
Dir["#{Dir.pwd}/spec/support/**/*.rb"].sort.each { |file| require file }

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.include Mongoid::Matchers

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

