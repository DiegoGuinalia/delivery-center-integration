# frozen_string_literal: true

class CreateOrderOperation
  include Interactor

  delegate :params, to: :context

  def call
    if Order.where(external_code: context.order_data[:external_code]).count == 0
      create_customer
      create_order
      create_address
      create_items
      create_payments
    end
  end

  private

  def create_customer
    customer = Customer.where(external_code: context.customer_data[:external_code]).first
    if customer.nil?
      context.customer = Customer.create(context.customer_data)
    else
      customer.update(context.customer_data)
      context.customer = customer
    end
  end

  def create_order
    context.order_data[:created_at] = context.order_data[:dtOrderCreate]
    context.order_data.delete(:dtOrderCreate)

    order = Order.where(external_code: context.order_data[:external_code]).first
    if order.nil?
      context.order = context.customer.orders.build(context.order_data)
      context.order.save
    else
      order.update(context.order_data)
      context.order = order
    end
  end

  def create_address
    context.address = context.order.build_address(context.address_data)
    context.address.save
  end

  def create_payments
    context.payments = context.payments_data.map do |payment_data|
      payment = context.order.payments.build(payment_data)
      payment.save
      payment
    end
  end

  def create_items
    context.items = []
    context.order_items = []

    context.items_data.each do |item_data|
      item = Item.where(external_code: item_data[:external_code]).first
      if item.nil?
        item = Item.create(item_data.except(:quantity, :total))
        order_item = context.order.order_items.build(item_data.slice(:quantity, :total))
        order_item.item = item
        order_item.save

        context.items << item

        context.order_items << order_item
      else
        item.update(item_data.except(:quantity, :total))
        order_item = context.order.order_items.build(item_data.slice(:quantity, :total))
        order_item.item = item
        order_item.save

        context.items << item
        context.order_items << order_item
      end
    end
  end
end
