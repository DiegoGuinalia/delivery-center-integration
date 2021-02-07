#!/usr/bin/env ruby

#frozen_string_literal: true
require_relative '../api'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_HOST'] }
end