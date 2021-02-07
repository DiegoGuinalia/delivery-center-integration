# frozen_string_literal: true

module Controllers
  class Orders
    class << self
      def parsing_order(_request)
        params = JSON.parse(_request.params.to_json, symbolize_names: true)
        result = PlaceOrder.call(params: params)

        if result.success?
          render json: {
            result: 'success',
          }, status: 201
        else
          render json: {
            result: 'failed',
          }, status: 422
        end
      end
    end
  end
end
