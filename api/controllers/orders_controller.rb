# frozen_string_literal: true

module Controllers
  class Orders
    class << self
      def parsing_order(_request)
        params = JSON.parse(_request.params.to_json, symbolize_names: true)
        result = PlaceOrder.call(params: params)

        if result.success?
          body = { result: 'success' }
          _request.success(body)
        else
          body = { result: 'failed', error: result.error }
          _request.unprocessable_entity(body)
        end
      end
    end
  end
end
