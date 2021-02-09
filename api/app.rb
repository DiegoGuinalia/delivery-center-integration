# frozen_string_literal: true

# Routes e Controller for App
class App < Roda
  include Support::RodaPlugins

  route do |r|
    _request = Support::ApiResponse.new r

    r.root do
      msg = { status: 'online', version: VERSION.to_s }
      _request.success msg
    end

    r.on 'api' do
      r.on 'v1' do
        r.on 'orders' do
          r.post 'parse_order' do
            Controllers::Orders.parsing_order(_request)
          end
        end
      end
    end
  end
end
