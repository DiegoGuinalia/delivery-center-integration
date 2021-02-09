class IntegrationOrderOperation
  include Interactor

  delegate :params, to: :context

  def call
    send_order
  end

  private

  def send_order
    service = DeliveryCenterService.new

    response = service.send_order(body.to_json)

    context.fail!(error: response.body) if response.status != 200
  end

  def body
    payload = context.order_data.merge(context.address_data)
                     .merge(customer: context.customer_data)
                     .merge(items: context.items_data)
                     .merge(payments: context.payments_data)

    payload_camelized = payload.to_camelback_keys
    payload_camelized[:total_shipping] = payload_camelized[:totalShipping]
    payload_camelized.delete(:totalShipping)
    payload_camelized
  end
end
