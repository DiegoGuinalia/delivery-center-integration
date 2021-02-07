# frozen_string_literal: true

module Support
  # Included this module for added methods into class
  module RodaPlugins
    def self.included(klass)
      klass.plugin :all_verbs
      klass.plugin :json
      klass.plugin :hash_routes
      klass.plugin :halt
      klass.plugin :request_headers
      klass.plugin :environments
    end
  end
end