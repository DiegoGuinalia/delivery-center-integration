ENV['RACK_ENV'] = 'test'

require "../lib/app"

RSpec.configure do |config|
  config.include Rack::Test::Methods
end