# fronzen_string_literal: true

require './lib/api'

run Rack::Cascade.new([App])
