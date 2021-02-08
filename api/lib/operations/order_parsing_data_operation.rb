class OrderParsingDataOperation
  include Interactor

  delegate :params, to: :context

  def call
    validate_contract
    parse_data
  end

  private

  def validate_contract
    contract = OrderDataContract.new
    result = contract.call(params)

    context.fail!(error: result.errors.to_h) unless result.success?
  end

  def parse_data
    customer_parser = CustomerParser.new(context.params)
    context.customer_data = customer_parser.parse_customer

    order_parser = OrderParser.new(context.params)
    context.order_data = order_parser.parse_order

    address_parser = AddressParser.new(context.params)
    context.address_data = address_parser.parse_address

    items_parser = ItemsParser.new(context.params)
    context.items_data = items_parser.parse_items

    payments_parse = PaymentsParser.new(context.params)
    context.payments_data = payments_parse.parse_payments
  end
end
