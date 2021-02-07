# frozen_string_literal: true

module Controllers
  class Orders
    class << self
      def index(_request)
        msg = { status: 'render all orders' }
        _request.success msg
      end

      def parsing_order(_request)
        require 'pry'; binding.pry
      end
    end
  end
end
